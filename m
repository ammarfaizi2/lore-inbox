Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163491AbWLGWJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163491AbWLGWJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163436AbWLGWJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:09:40 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:39538 "EHLO
	ns9.hostinglmi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163484AbWLGWJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:09:38 -0500
Date: Thu, 7 Dec 2006 23:10:15 +0100
From: DervishD <lkml@dervishd.net>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
Message-ID: <20061207221015.GA342@DervishD>
Mail-Followup-To: Matthias Schniedermeyer <ms@citd.de>,
	linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <45773DD2.10201@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45773DD2.10201@citd.de>
User-Agent: Mutt/1.4.2.2i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Matthias :)

 * Matthias Schniedermeyer <ms@citd.de> dixit:
> My averate file size is about 1GB with files from about 400MB to
> 5000MB I estimate the average error-rate at about one damaged file in
> about 10GB of data.
> 
> I'm not sure and haven't checked if the files are wrongly written or
> "only" wrongly read back as i delete the defective files and copy them
> again.
> 
> Today i copied a few files back and checked them against the stored MD5
> sums and 5 files of 86 (each about 700 MB) had errors. So i copied the 5
> files again. 4 of the files were OK after that and coping the last file
> the third time also resulted in the correct MD5.

    I had more or less the same issue a week or two ago. I performed
lots of tests and only by replacing the USB2.0 PCI card, the USB cable
and the power supply of the usb-hdd adapter got the problem solved.

    I'm not sure if the problem is really gone, but the system works now
reliably. I don't know if sooner or later I'll get the issue again,
because I didn't really identify a culprit: looks like the
card+adapter+cable combination was just "ugly", and errors from the
adapter were not reported correctly.

> NEVER did i see any messages in syslog regarding erros or an aborting
> program due to errors passed down from the kernel or something like
> that.

    The same here! Looks like USB-HDD adapters don't report any errors
to the kernel :?????

    The best advice I can give you, from my limited experience with the
problem, is: replace the cable. This minimizes the chance of corrupted
data getting into the adapter. If that doesn't solve the problem, try
removing any unconnected cable that is plugged into the USB card.
Believe it or not, a long but unconnected cable (put there just to be
able to plug my USB card-reader without having to look for the cable in
a drawer) was causing errors *even in a Kingston USB key that worked
flawlessly otherwise*!!!

    If you have any other question, feel free to drop me a note. I'm
sorry I cannot give a much more technical or scientific answer, but
unfortunately I have none :((

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
