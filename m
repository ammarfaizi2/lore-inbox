Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315111AbSENCba>; Mon, 13 May 2002 22:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315115AbSENCb3>; Mon, 13 May 2002 22:31:29 -0400
Received: from ns.neureal.com ([64.29.18.145]:14084 "HELO mail2.neureal.com")
	by vger.kernel.org with SMTP id <S315111AbSENCb3>;
	Mon, 13 May 2002 22:31:29 -0400
Message-ID: <003501c1faef$4fa621e0$050010ac@niunia.org>
From: "Artur Jasowicz" <arturj@mousebusiness.com>
To: "dean gaudet" <dean-list-linux-kernel@arctic.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205131521160.17160-100000@twinlark.arctic.org>
Subject: Re: downgrade ata udma mode at boot time?
Date: Mon, 13 May 2002 21:30:17 -0500
Organization: mousebusiness.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems with building/resyncing RAID as well. Here's what I did
for my two RH 7.2 machines:
In /etc/sysconfig/ I created new file called hdparm.cfg with following
content

-d 0 /dev/hde
-d 0 /dev/hdg
-d 0 /dev/hdi
-d 0 /dev/hdk

In /etc/rc.d/rc.sysinit right before root partition gets remounted r/w
(there may be a better spot for that, suggestions, anyone?) I added the
following:

# adjust hd parameters
if [ -e /etc/sysconfig/hdparm.cfg -a -x /sbin/hdparm ]; then
        action $"Adjusting hdparm:" /sbin/hdparm $(/bin/cat
/etc/sysconfig/hdparm.cfg)
fi

Crude, but works.

Artur

