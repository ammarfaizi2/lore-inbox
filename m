Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280729AbRKGBKk>; Tue, 6 Nov 2001 20:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280730AbRKGBKa>; Tue, 6 Nov 2001 20:10:30 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:19864 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S280729AbRKGBKN>; Tue, 6 Nov 2001 20:10:13 -0500
Date: Tue, 6 Nov 2001 20:10:01 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: <dalecki@evision.ag>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <3BE87CB9.43427FCF@evision-ventures.com>
Message-ID: <Pine.GSO.4.33.0111061947540.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Martin Dalecki wrote:
>And then converted back to ASCII for printout on the terminal ;-).

Well, they don't always get printf()'d...

>The second problem is that /proc is one of the few design "inventions" in
>linux, which didn't get copied over from some other UNIX box and Linus
>doesn't wan't recognize that this was A BAD DESIGN CHOICE.

/proc is a wonderful thing for what it was originally intended: access to
the process table without looking at the tables in the kernel memory space
(remember SunOS?  what happened if /vmunix wasn't the running kernel?)
Unfortunately, /proc has become the gheto of the Linux kernel.  It is now
the general dumping grounds for user/kernel interfacing.  As a developer tool
it's very handy; it's also very dangerous.  Developers then resort to
/proc as a perminant interface between kernel drivers and userland. (In
the *BSD world, this is a kernfs, not a procfs.)

For an example of /proc done right, find a Solaris box.  What do you find
in /proc?  Gee, process information.  Only process information.  In. Binary.

--Ricky


