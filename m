Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264612AbSJNKGM>; Mon, 14 Oct 2002 06:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSJNKGL>; Mon, 14 Oct 2002 06:06:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26382 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264612AbSJNKD7>; Mon, 14 Oct 2002 06:03:59 -0400
Date: Mon, 14 Oct 2002 11:09:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] mmap.c (do_mmap_pgoff), against 2.4.19 and 2.4.20-pre10
Message-ID: <20021014110947.B32186@flint.arm.linux.org.uk>
References: <20021014093622.GA96@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014093622.GA96@DervishD>; from raul@pleyades.net on Mon, Oct 14, 2002 at 11:36:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:36:22AM +0200, DervishD wrote:
>     Well, the attachments included (unified diff format), is the patch
> against both 2.4.19 and 2.4.20-pre10 (I've changed the kernel name
> directory part to '/usr/src/linux/' so it's applicable to both
> versions.

You could try sending a patch that conforms to the following (why don't
we include a comment about this in Documentation/SubmittingPatches?)

This would remove an extra reason why your patch may not have been
accepted.

PATCH(1)                                                 PATCH(1)

NAME
       patch - apply a diff file to an original
...
NOTES FOR PATCH SENDERS
       There  are  several  things you should bear in mind if you
       are going to be sending out patches.
...
       If the recipient is supposed to use the -pN option, do not
       send output that looks like this:

          diff -Naur v2.0.29/prog/README prog/README
          --- v2.0.29/prog/README   Mon Mar 10 15:13:12 1997
          +++ prog/README   Mon Mar 17 14:58:22 1997

       because the two  file  names  have  different  numbers  of
       slashes,  and  different  versions  of patch interpret the
       file names differently.

Content-Description: mmap.c.diff
> --- /usr/src/linux/mm/mmap.c.orig	2002-10-14 11:16:40.000000000 +0200
> +++ /usr/src/linux/kernel/mm/mmap.c	2002-10-14 11:19:32.000000000 +0200

Also, you should generate the patches without the "/usr/src/" prefix.
So it should look like this:

--- linux/mm/mmap.c.orig	2002-10-14 11:16:40.000000000 +0200
+++ linux/mm/mmap.c	2002-10-14 11:19:32.000000000 +0200

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

