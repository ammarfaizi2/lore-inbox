Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTEMSoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTEMSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:42:42 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:27922 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S262638AbTEMSlT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:41:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Andreas Schwab <schwab@suse.de>, Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: inode values in file system driver
Date: Tue, 13 May 2003 19:54:24 +0100
User-Agent: KMail/1.4.3
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, linux-kernel@vger.kernel.org
References: <200305102118.20318.adrian@mcmen.demon.co.uk> <16065.1422.44816.110091@laputa.namesys.com> <jeptmmgaiv.fsf@sykes.suse.de>
In-Reply-To: <jeptmmgaiv.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305131954.24909.adrian@mcmen.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 May 2003 15:56, Andreas Schwab wrote:
> Nikita Danilov <Nikita@Namesys.COM> writes:
> |> Andreas Schwab writes:
> |>  > Erik Mouw <J.A.K.Mouw@its.tudelft.nl> writes:
> |>  > |> On Sat, May 10, 2003 at 09:18:20PM +0100, Adrian McMenamin wrote:
> |>  > |> > Am I allowed to assign the value 0 to an inode in a file system
> |>  > |> > driver? I seem to be having problems with a file that is being
> |>  > |> > assigned this inode value (its a FAT based filesystem so the
> |>  > |> > inode values are totally artificial).
> |>  > |>
> |>  > |> Yes, you are. However, glibc thinks that inode 0 is special and
> |>  > |> won't show it.
> |>  >
> |>  > BS. This has nothing at all to do with glibc.
> |>
> |> from glibc-2.2.4/sysdeps/unix/readdir.c:
> |>
> |>       /* Skip deleted files.  */
> |>     } while (dp->d_ino == 0);
> |>
> |> In other words, readdir(3) will not return dirent for inode with ino 0.
>
> I stand corrected.  I was thinking of getdirentries, which does not have
> this problem.  But this is traditional Unix behaviour.
>
> Andreas.


Thanks. At least I know why my driver is failing now.

Adrian

