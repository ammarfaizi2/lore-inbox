Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285153AbRLMUJd>; Thu, 13 Dec 2001 15:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285147AbRLMUJX>; Thu, 13 Dec 2001 15:09:23 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S285155AbRLMUJO>;
	Thu, 13 Dec 2001 15:09:14 -0500
Message-ID: <08d701c18412$0e91d2c0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <root@chaos.analogic.com>
Cc: "Thomas Capricelli" <orzel@kde.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1011213142534.1037A-100000@chaos.analogic.com>
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: Thu, 13 Dec 2001 15:09:16 -0500
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
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Thomas Capricelli" <orzel@kde.org>; <linux-kernel@vger.kernel.org>
Sent: Thursday, December 13, 2001 2:41 PM
Subject: Re: Mounting a in-ROM filesystem efficiently


> On Thu, 13 Dec 2001, Bradley D. LaRonde wrote:
>
> > ----- Original Message -----
> > From: "Richard B. Johnson" <root@chaos.analogic.com>
> > To: "Bradley D. LaRonde" <brad@ltc.com>
> > Cc: "Thomas Capricelli" <orzel@kde.org>; <linux-kernel@vger.kernel.org>
> > Sent: Thursday, December 13, 2001 1:34 PM
> > Subject: Re: Mounting a in-ROM filesystem efficiently
> > > Well RAM is a hell of a lot cheaper than NVRAM. If you don't have
> > > the required RAM on your box, the hardware engineers screwed up
> > > and have to be "educated" preferably with an axe in the parking-lot.
> >
> > As I mentioned before, there may be other-than-cost considerations for
> > choosing the amount of RAM on a box.  For example, low power consumption
on
> > portable devices.  For another example, a huge ROM database that doesn't
> > need to be in RAM all at once.
> >
> > Regards,
> > Brad
> >
>
> Then you make a block-device device-driver that extracts and uncompresses
> each read from ROM/NVRAM upon demand. It pretends to write. The actual
> data-storage device is still paged and it only writes to the caller's
> buffer so it doesn't use any RAM for storage.

Or you could use cramfs + the patch that I mentioned a few e-mails ago.  :-)

> There are many arguments, but I don't think power consumption is
> one of them. Whatever they use for RAM on the palm machines allows
> the machines to run a week on 4 'aa' -size batteries. Maybe they
> grab kinetic energy from keystrokes using flea-generators ^;).

No flea-generators that I know of.  :-)

SDRAM, even in self-refresh mode, does draw considerable current.  But then
again so does decompressing stuff from ROM all the time.

Regards,
Brad

