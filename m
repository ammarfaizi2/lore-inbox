Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVBVUq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVBVUq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVBVUq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:46:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:56481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261235AbVBVUqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:46:22 -0500
Date: Tue, 22 Feb 2005 12:46:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: dtor_core@ameritech.net
cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
In-Reply-To: <d120d50005022211384a83726d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0502221244210.2378@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502201049480.18753@skynet> 
 <21d7e997050220150030ea5a68@mail.gmail.com>  <9e4733910502201542afb35f7@mail.gmail.com>
  <1108973275.5326.8.camel@gaston>  <9e47339105022111082b2023c2@mail.gmail.com>
  <1109019855.5327.28.camel@gaston>  <9e4733910502211717116a4df3@mail.gmail.com>
  <1109041968.5412.63.camel@gaston>  <9e473391050221204215a079e1@mail.gmail.com>
  <Pine.LNX.4.58.0502221111410.2378@ppc970.osdl.org> <d120d50005022211384a83726d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Feb 2005, Dmitry Torokhov wrote:
> 
> This sounds awfully like firmware loader that seems to be working just
> fine for a range of network cards and other devices.

Yes. HOWEVER - and note how firmware loading for this case is not validly
done at device discovery, but at "ifconfig" time.

Ie device discovery (probing) is a _separate_ phase entirely, and happens 
much earlier. We should initialize the hardware only when it actually gets 
"acively used" some way by user space.

			Linus
