Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268360AbTBNJzV>; Fri, 14 Feb 2003 04:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268367AbTBNJzV>; Fri, 14 Feb 2003 04:55:21 -0500
Received: from gate.in-addr.de ([212.8.193.158]:26632 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S268360AbTBNJzT>;
	Fri, 14 Feb 2003 04:55:19 -0500
Date: Fri, 14 Feb 2003 11:03:16 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels
Message-ID: <20030214100316.GA3422@marowsky-bree.de>
References: <20030213194917.GA8479@quadpro.stupendous.org> <E18jS75-0007na-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E18jS75-0007na-00@calista.inka.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-02-13T23:45:51,
   Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net> said:

> You can use the multipath option to md which can do that.
> 
> Basically there are two options, a failover and a load balancing option. The
> problem with failover is, to detect the actual failure reliable, toe problem
> with load balancing is, that not all san configurations allow this.
> 
> http://www-124.ibm.com/storageio/multipath/md-multipath/index.php
> 
> this is at least in 2.4.20-xfs

That one? Ouch, it is a bit dated according to the webpage ;-) I don't recall
that it was discussed on LKML, either.

SuSE (Jens Axboe and myself) have also done work on the md multipathing,
supporting failover and load balancing and in general giving the code a rinse;
as well as extensions to mdadm to make them work.

The patches currently live at http://lars.marowsky-bree.de/dl/md-mp/

(And are included in SuSE's kernel release, of course ;-)

Currently, for 2.5 / 2.6, I think I really like the SCSI midlayer stuff. In
the past, I didn't, because it constrains everything to SCSI. But then,
everything so far _has_ been SCSI, except for weird arch stuff like s390(x)
DASDs ;-)

Doing it in the SCSI layer has the advantage of not being constrained to block
devices, but also working with tapes. Oh well, we'll see ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
