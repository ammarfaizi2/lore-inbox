Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbUBVUDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbUBVUDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:03:18 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:11362 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261737AbUBVUDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:03:16 -0500
Date: Sun, 22 Feb 2004 22:03:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6 build oddity...
Message-ID: <20040222210349.GA14932@mars.ravnborg.org>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040222081959.GA21170@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222081959.GA21170@one-eyed-alien.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 12:19:59AM -0800, Matthew Dharm wrote:
> I'm not sure where to report this....
> 
> In some sort of freak accident, I had a .s file in my source tree.
> Whenever I did a build (make bzImage modules), the build process would:
> (1) check out the corresponding .c file
> (2) build the .s into the .o
> (3) delete the .c file

I have tried to reproduce this locally (with 2.6 kernel btw).
make
make kernel/pid.s
rm kernel/pid.c

And as you tell, the .c file is checked out. But I can here that
also the .c file is used when compiling pid.o.

Care to provide a few more details, such as:

- Kernel version
- What file is was
- What SCM you are using (uses bk here)
- Full log of what is happening (off-list is fine)

	Sam

> Which I find odd, because:
> (1) It never used the .c file, but checked it out anyway
> (2) It _did_ delete the .c file, without using it
> 
> Matt
> 
> -- 
> Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.net 
> Maintainer, Linux USB Mass Storage Driver
> 
> G:  Let me guess, you started on the 'net with AOL, right?
> C:  WOW! d00d! U r leet!
> 					-- Greg and Customer 
> User Friendly, 2/12/1999



-- 
