Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTEMOfD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbTEMOfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:35:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:60037 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261252AbTEMOfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:35:02 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.1422.44816.110091@laputa.namesys.com>
Date: Tue, 13 May 2003 18:47:42 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andreas Schwab <schwab@suse.de>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
       Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: inode values in file system driver
In-Reply-To: <je3cjihq6h.fsf@sykes.suse.de>
References: <200305102118.20318.adrian@mcmen.demon.co.uk>
	<20030513135150.GA1049@arthur.home>
	<je3cjihq6h.fsf@sykes.suse.de>
X-Mailer: VM 7.14 under 21.5  (beta11) "cabbage" XEmacs Lucid
Emacs: if SIGINT doesn't work, try a tranquilizer.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab writes:
 > Erik Mouw <J.A.K.Mouw@its.tudelft.nl> writes:
 > 
 > |> On Sat, May 10, 2003 at 09:18:20PM +0100, Adrian McMenamin wrote:
 > |> > Am I allowed to assign the value 0 to an inode in a file system driver? I seem 
 > |> > to be having problems with a file that is being assigned this inode value 
 > |> > (its a FAT based filesystem so the inode values are totally artificial).
 > |> 
 > |> Yes, you are. However, glibc thinks that inode 0 is special and won't
 > |> show it.
 > 
 > BS. This has nothing at all to do with glibc.

from glibc-2.2.4/sysdeps/unix/readdir.c:

      /* Skip deleted files.  */
    } while (dp->d_ino == 0);

In other words, readdir(3) will not return dirent for inode with ino 0.

 > 
 > Andreas.
 > 

Nikita.
