Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbSKFJvr>; Wed, 6 Nov 2002 04:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSKFJvr>; Wed, 6 Nov 2002 04:51:47 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:21987 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263178AbSKFJvq> convert rfc822-to-8bit; Wed, 6 Nov 2002 04:51:46 -0500
Message-ID: <3DA24C0A01244F0A@mel-rta10.wanadoo.fr> (added by
	    postmaster@wanadoo.fr)
Date: Wed, 06 Nov 2002 10:57:41 +0100 (MET)
From: "Emmanuel FUSTE" <e.fuste@wanadoo.fr>
To: <phil@fifi.org>
Cc: <linux-kernel@vger.kernel.org>
References: <1036535689.3349.36.camel@rafale>   <87bs53qyli.fsf@ceramic.fifi.org>
Subject: Re: aic7xxx problem.  (PCI related =?iso-8859-1?Q?=3F)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which hardware is connected to your SCSI adapter? (hint: cat /proc/scsi/scsi)
> 
> I've found out that some IBM hard disks give the above error when too
> many tagged commands are queued (firmware bug probably). I definitely
> have a DDRS-39130D drive which shows this behavior. The old SCSI
> driver (5.x) was not as bold as the 6.x driver which is in 2.4 with
> regards to queueing: the 6.x driver use 253 tagged command openings by
> default.
> 
> For me, passing `aic7xxx=tag_info:{{,,,8}}' to the kernel solved the
> problems. The above tells the aic7xxx driver to limit tagged queuing
> depth to 8 for the drive at ID 3 on the first aic7xxx adapter, but
> YMMV.
> 
> Phil.

Thanks Phil, unfortunately, this doesnt solve my problem.
The 5.x driver never worked for me on the 2940u2w, it lock the computer.

I could even trigger the kernel message with no devices attached to the scsi bus.
With the two adapters in the computer, when I issue a scsiadd -s 1, I've got the
errors but whithout  the hard lock.

For reference:
http://marc.theaimsgroup.com/?l=linux-kernel&m=99295558926036&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=100852862320948&w=2

Is someone knew something about my pblm with the pci latency timer set to 0 ?

Emmanuel.

