Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVKFApa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKFApa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVKFAp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:45:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932250AbVKFApS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:45:18 -0500
Date: Sat, 5 Nov 2005 16:45:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mlang@debian.org
Subject: Re: [PATCH] Set the vga cursor even when hidden
In-Reply-To: <436D5047.4080006@gmail.com>
Message-ID: <Pine.LNX.4.64.0511051642580.3316@g5.osdl.org>
References: <20051105211949.GM7383@bouh.residence.ens-lyon.fr>
 <436D5047.4080006@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Nov 2005, Antonino A. Daplas wrote:
> 
> Note that this method will produce a split block cursor with EGA, which is
> still supported by vgacon, but possibly not used anymore.  Why not use
> this method (scanline_end < scanline_start) for VGA, and the default method
> (moving the cursor out of the screen) for the rest?

I do believe that we can ignore EGA controllers these days.

Or at least accept the fact that anybody who owns an EGA system isn't 
actually likely to care about what his screen looks like.

The EGA support was pretty much a joke even when Linux started ;)

		Linus
