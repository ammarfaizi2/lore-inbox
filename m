Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289471AbSA1Tqf>; Mon, 28 Jan 2002 14:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289516AbSA1Tq0>; Mon, 28 Jan 2002 14:46:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28681 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289462AbSA1TpV>; Mon, 28 Jan 2002 14:45:21 -0500
Subject: Re: Ethernet data corruption?
To: mrproper@ximian.com (Kevin Breit)
Date: Mon, 28 Jan 2002 19:57:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1012250404.5401.6.camel@kbreit.lan> from "Kevin Breit" at Jan 28, 2002 02:40:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VHub-0001Zg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We tried http, ftp, and other protocols, using different download
> applications.  It seemed to be corrupt, the same way, everytime.  It
> wouldn't work, and had a different md5sum than the "good" version on my
> friend's computer.  Eventually we got it working.
> 	The same issue came up again today.  I uploaded my Java project on my
> professor's server and it gives me an error.  However, if I load the
> html file with the Java applet in my web browser from this hard disk
> (instead of from the prof's), it works.
> 	I am wondering if there is some sort of corruption going on here.  I am
> using Red Hat's 2.4.9-21 kernel.

At the physical layer ethernet has hardware checksumming, at the IP/TCP layer
there is also checksum protection. That means that its almost certainly either

-	Problem hardware/driver
-	Some kind of broken transparent proxy server between the two boxes

What you really want to try is to upload the same files via different
machines to find out which end is the problem, or if it is perhaps the
link between them - eg does it go away only if both boxes are on the same
LAN.

Alan
