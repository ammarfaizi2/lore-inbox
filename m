Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285177AbRLMUwO>; Thu, 13 Dec 2001 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRLMUwI>; Thu, 13 Dec 2001 15:52:08 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S285178AbRLMUv4>;
	Thu, 13 Dec 2001 15:51:56 -0500
Message-ID: <096201c18418$07d86bf0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <9vb3k4$9kj$1@cesium.transmeta.com>
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: Thu, 13 Dec 2001 15:52:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "H. Peter Anvin" <hpa@zytor.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 13, 2001 3:38 PM
Subject: Re: Mounting a in-ROM filesystem efficiently


> Followup to:  <20011213160007.D998D23CCB@persephone.dmz.logatique.fr>
> By author:    Thomas Capricelli <orzel@kde.org>
> In newsgroup: linux.dev.kernel
>
> > Ideally, i would give address/length of the fs in ROM to a function, and
I
> > would get a ramdisk configured to read its data exactly there, and not
in
> > ram.
>
> The right thing for you to do is to write a block device driver, and
> then mount that block device like any order device.  Your in-use data
> will be copied to RAM (i.e. cached), but it can be dropped and
> re-fetched as necessary.  This should be the desired behaviour.

That's one way (q.v. MTD block device), but it adds an unecessary block
layer.

The cramfs patch I mentioned shuns the block layer and instead allows the fs
to read directly from ROM.

Regards,
Brad

