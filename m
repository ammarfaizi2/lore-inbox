Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWIZW6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWIZW6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWIZW6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:58:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:33805 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932484AbWIZW6S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:58:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=lwOIaobEzwQcptxG4tieL1GnjAuu/JLiFAocO5II3255Uw24JRhCWYhx9gDW80Gyi7TAO5FsyY59706APvqOCm9UGusO9oiou4+HOPpLjmoZAa7oj46xiNX48iBmphxtZcwPJkbvdBu83E/Ro+7g8xpplgxdaexPun1+OVJI8Bw=
Date: Wed, 27 Sep 2006 00:58:13 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: pata_serverworks oopses in latest -git
Message-Id: <20060927005813.09154c74.diegocg@gmail.com>
In-Reply-To: <1159312008.11049.323.camel@localhost.localdomain>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	<1159275010.11049.215.camel@localhost.localdomain>
	<45194DAD.6060904@garzik.org>
	<20060926212939.69b52f0d.diegocg@gmail.com>
	<1159300946.11049.300.camel@localhost.localdomain>
	<20060926223857.56b0047d.diegocg@gmail.com>
	<1159305871.11049.316.camel@localhost.localdomain>
	<20060927002149.06c934e8.diegocg@gmail.com>
	<1159312008.11049.323.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 27 Sep 2006 00:06:48 +0100,
Alan Cox <alan@lxorguk.ukuu.org.uk> escribió:

> > [  129.270661] sr 2:0:0:0: SCSI error: return code = 0x08000002
> > [  129.270675] sr0: Current: sense key=0x3
> 
> MEDIUM ERROR. As reported by the drive.


Mmh, this dvd does work with the old ide driver. I've tested other
DVDs and it always happens, but this is very weird...totem is able
to read it for 3 or 4 seconds, then totem hangs, it popups an error,
and I'll get error messages in dmesg:

[ 2980.945085] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'cqc2', timestamp 2036/02/07 03:58 (1078)
[ 3012.955882] sr 2:0:0:0: SCSI error: return code = 0x08000002
[ 3012.955897] sr0: Current: sense key=0x3
[ 3012.955903]     ASC=0x10 <<vendor>> ASCQ=0x90
[ 3012.955917] end_request: I/O error, dev sr0, sector 79104
[ 3012.955926] printk: 54 messages suppressed.
[ 3012.955933] Buffer I/O error on device sr0, logical block 19776
[ 3012.955949] Buffer I/O error on device sr0, logical block 19777
[ 3012.955961] Buffer I/O error on device sr0, logical block 19778
[ 3012.955970] Buffer I/O error on device sr0, logical block 19779
[ 3012.955979] Buffer I/O error on device sr0, logical block 19780
[ 3012.955988] Buffer I/O error on device sr0, logical block 19781
[ 3012.955997] Buffer I/O error on device sr0, logical block 19782
[ 3012.956005] Buffer I/O error on device sr0, logical block 19783
[ 3012.956014] Buffer I/O error on device sr0, logical block 19784
