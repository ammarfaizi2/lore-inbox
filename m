Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUI2FZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUI2FZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 01:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUI2FZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 01:25:25 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:47897 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268228AbUI2FZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 01:25:15 -0400
Message-ID: <9e47339104092822253015bb52@mail.gmail.com>
Date: Wed, 29 Sep 2004 01:25:12 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409290311190.11496@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <Pine.LNX.4.58.0409290009050.11496@skynet>
	 <9e473391040928182765efd7ab@mail.gmail.com>
	 <Pine.LNX.4.58.0409290311190.11496@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found the problem with multiple drivers, it's in the mapping
code. When drivers close their handles they are deleting permanent
maps that don't belong to them. I'll fix it tomorrow.

-- 
Jon Smirl
jonsmirl@gmail.com
