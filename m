Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUJTR3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUJTR3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268728AbUJTR2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:28:42 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:51631 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268670AbUJTR1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:27:24 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Paulo Marques <pmarques@grupopie.com>
Date: Wed, 20 Oct 2004 10:27:08 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org
Message-ID: <41763D7C.32014.1B52EDB8@localhost>
In-reply-to: <417682D5.2020803@grupopie.com>
References: <416E8322.25700.29ACC2F1@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> wrote:

> >>How big is the module with emulator etc.? 
> > 
> > About 150K compiled on x86 (before linking so that has symbol information 
> > etc in it).
> 
> I searched for the code in the scitech FTP server... If this code
> is similar to the one found under "../obsolete/.." then it seems
> that the code is somewhat optimized for speed, whereas for video
> initialization we probably could rework it to be optimized for
> code size. 

No, the code is not under /obsolete/ but under /scitech/src/x86emu (well 
at least the x86 emulator portion is). It is active code we are using as 
well as sharing with the X.org server (time we did a sync actually ;-).

> If the complete interpreter could fit in 64k (or something like
> that) then the chances of it getting into the kernel would be
> probably higher and could solve a lot of problems. 

Given the nature of the problems at the fact that most machines where a 
real video card would be used have more than enough space to add 150K to 
the kernel, making it smaller would be mostly an academic exercise IMHO.

For instance the embedded machines that usually run video normally have 
at least 16M of memory, usually 32M or more. Mostly because once the 
kernel is up they do a lot of stuff that needs a ton more memory than a 
measly 150K, such as playing MPEG2 movies, playing MP3 files etc etc.

Although it would certainly be nice if it could be made smaller, I am not 
sure how much smaller it could be trimmed down to since the code was 
designed originally for functionality not necessarily speed. But you 
never know - perhaps some clever rearrangement of the code could make it 
smaller.

> This is a problem I find somewhat interesting, and would be
> willing to give it some of my spare time... 

By all means feel free to look and see what you can do. If you do make it 
smaller, I am sure the X.org folks would also be interested. We don't 
have the latest version of the emulator code on our ftp site (we are 
working on that) but the only difference between the code up there and 
the new code is a few bugs that we have fixed. The structure and 
functionality is identical.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


