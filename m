Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSILTyB>; Thu, 12 Sep 2002 15:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSILTyB>; Thu, 12 Sep 2002 15:54:01 -0400
Received: from [208.34.239.138] ([208.34.239.138]:19590 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S317170AbSILTyA>; Thu, 12 Sep 2002 15:54:00 -0400
Date: Thu, 12 Sep 2002 15:58:39 -0400
From: Phil Stracchino <alaric@babcom.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: CDROM driver does not support Linux partition tables
Message-ID: <20020912195839.GA13150@babylon5.babcom.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20020904181952.GA1158@babylon5.babcom.com> <1031182512.3017.139.camel@irongate.swansea.linux.org.uk> <20020911211959.GA31724@babylon5.babcom.com> <1031779715.2838.4.camel@irongate.swansea.linux.org.uk> <20020912050620.GG30234@suse.de> <1031817597.2994.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031817597.2994.35.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-ICBM: 35.6880N 77.4375W
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
X-UCE-Policy: No unsolicited commercial email is accepted at this site.  All senders of UCE will be immediately and permanently blocked.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 08:59:57AM +0100, Alan Cox wrote:
> On Thu, 2002-09-12 at 06:06, Jens Axboe wrote:
> > > It ought to be supportable on scsi cd or with ide-scsi. ide-cd has no
> > > minor space for partitioning, ide-scsi/sr do support partitions.
> > 
> > The opposite, surely? sr uses one minor per cd-rom, ide-cd has 64.
> 
> Brain on stun. Yes ide-scsi is a problem ide-cd gets it right. This is
> something that really ought to get fixe durin 2.5


Hrm.  Then how does one access the other minors?  I tried creating the
presumed-appropriate device nodes directly via mknod (cdrom0 was 22,0; I
created 22,1 22,2 22,3) without success.  I didn't have ide-scsi loaded
at the time.


-- 
 *********  Fight Back!  It may not be just YOUR life at risk.  *********
 :phil stracchino : unix ronin : renaissance man : mystic zen biker geek:
 : alaric@babcom.com   :::   alaric@geeksnet.com   :::    phil@latt.net :
 :  2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)  :
 :    Linux Now! ...because friends don't let friends use Microsoft.    :
