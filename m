Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVBZAsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVBZAsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVBZAse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:48:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:38345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262111AbVBZAsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:48:30 -0500
Date: Fri, 25 Feb 2005 16:49:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc5
In-Reply-To: <20050226004137.GA25539@suse.de>
Message-ID: <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Feb 2005, Olaf Hering wrote:
> 
> modedb can not be __init because fb_find_mode() may get db == NULL.
> fb_find_mode() is called from modules.

Ack. Maybe somebody should run the scripts again to check that we don't 
reference __init data from non-init functions.

		Linus
