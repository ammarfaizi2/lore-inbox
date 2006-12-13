Return-Path: <linux-kernel-owner+w=401wt.eu-S964900AbWLMTgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWLMTgd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWLMTgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:36:32 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:41267 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964900AbWLMTga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:36:30 -0500
Date: Wed, 13 Dec 2006 20:33:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nikolai Joukov <kolya@cs.sunysb.edu>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@filer.fsl.cs.sunysb.edu, fistgen@filer.fsl.cs.sunysb.edu
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <Pine.GSO.4.53.0612122217360.22195@compserv1>
Message-ID: <Pine.LNX.4.61.0612132031220.32433@yvahk01.tjqt.qr>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>We have designed a new stackable file system that we called RAIF:
>Redundant Array of Independent Filesystems.
>
>Similar to Unionfs, RAIF is a fan-out file system and can be mounted over
>many different disk-based, memory, network, and distributed file systems.
>RAIF can use the stable and maintained code of the other file systems and
>thus stay simple itself.  Similar to standard RAID, RAIF can replicate the
>data or store it with parity on any subset of the lower file systems.  RAIF
>has three main advantages over traditional driver-level RAID systems:
>
>1. RAIF can be mounted over any set of file systems.  This allows users to
>   create many more useful configurations.  For example, it is possible to
>   replicate the data on the local and remote disks, and stripe the data on
>   the local hard drives and keep the parity (or even ECC to tolerate
>   multiple failures) on the remote server(s).  In the latter case, all the
>   read requests will be satisfied from the fast local disks and no local
>   disk space will be spent on parity.

As for striping on a simplistic level, look at the Equal File 
Distribution patch for unionfs :-)

http://www.mail-archive.com/unionfs@mail.fsl.cs.sunysb.edu/msg01936.html

Files are stored normally so that after the union is unmounted, the 
files appear in one piece (unlike real RAID0 over two block devices).


	-`J'
-- 
