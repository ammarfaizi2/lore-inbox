Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTEMOoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTEMOoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:44:12 -0400
Received: from ns.suse.de ([213.95.15.193]:2579 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261288AbTEMOoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:44:10 -0400
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
       Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: inode values in file system driver
References: <200305102118.20318.adrian@mcmen.demon.co.uk>
	<20030513135150.GA1049@arthur.home> <je3cjihq6h.fsf@sykes.suse.de>
	<16065.1422.44816.110091@laputa.namesys.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Everything will be ALL RIGHT if we can just remember things about
 ALGEBRA.. or SOCCER..  or SOCIALISM..
Date: Tue, 13 May 2003 16:56:56 +0200
In-Reply-To: <16065.1422.44816.110091@laputa.namesys.com> (Nikita Danilov's
 message of "Tue, 13 May 2003 18:47:42 +0400")
Message-ID: <jeptmmgaiv.fsf@sykes.suse.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> writes:

|> Andreas Schwab writes:
|>  > Erik Mouw <J.A.K.Mouw@its.tudelft.nl> writes:
|>  > 
|>  > |> On Sat, May 10, 2003 at 09:18:20PM +0100, Adrian McMenamin wrote:
|>  > |> > Am I allowed to assign the value 0 to an inode in a file system driver? I seem 
|>  > |> > to be having problems with a file that is being assigned this inode value 
|>  > |> > (its a FAT based filesystem so the inode values are totally artificial).
|>  > |> 
|>  > |> Yes, you are. However, glibc thinks that inode 0 is special and won't
|>  > |> show it.
|>  > 
|>  > BS. This has nothing at all to do with glibc.
|> 
|> from glibc-2.2.4/sysdeps/unix/readdir.c:
|> 
|>       /* Skip deleted files.  */
|>     } while (dp->d_ino == 0);
|> 
|> In other words, readdir(3) will not return dirent for inode with ino 0.

I stand corrected.  I was thinking of getdirentries, which does not have
this problem.  But this is traditional Unix behaviour.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
