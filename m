Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291553AbSBMLDD>; Wed, 13 Feb 2002 06:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291560AbSBMLCz>; Wed, 13 Feb 2002 06:02:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13831 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291553AbSBMLCf>; Wed, 13 Feb 2002 06:02:35 -0500
Subject: Re: Quick question on Software RAID support.
To: marco@esi.it (Marco Colombo)
Date: Wed, 13 Feb 2002 11:15:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202131109270.21300-100000@Megathlon.ESI> from "Marco Colombo" at Feb 13, 2002 11:33:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16axOE-0004zX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Is it supposed to detect a failed disk and *stop* using it?

Yes, it will stop using it and if appropriate try and do a rebuild

> I had a raid1 IDE system, and it was continuosly raising hard errors on
> hdc (the disk was dead, non just some bad blocks): the net result was that
> it was unusable - too slow, too busy on IDE errors (a lot of them - even
> syslog wasn't happy).

Don't try and do "hot pluggable" IDE raid it really doesn't work out. With
scsi the impact of a sulking drive is minimal unless you get unlucky
(I have here a failed SCSI SCA drive that hangs the entire bus merely by
being present - I use it to terrify HA people 8))

> BTW, given a 2 disks IDE raid1 setup (hda / hdc), does it pay to put a
> third disk in (say hdb) and configure it as "spare disk"? I've got 
> concerns about the slave not actually beeing able to operate if the
> master (hda) fails badly.

Well placed concerns. I don't know what Andre thinks but IMHO spend the
extra $20 to put an extra highpoint controller in the machine for the third
IDE bus.

Alan
