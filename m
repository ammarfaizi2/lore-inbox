Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293402AbSCXPID>; Sun, 24 Mar 2002 10:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293432AbSCXPHy>; Sun, 24 Mar 2002 10:07:54 -0500
Received: from ls212.hinet.hr ([195.29.150.91]:43683 "EHLO ls212.hinet.hr")
	by vger.kernel.org with ESMTP id <S293402AbSCXPHn>;
	Sun, 24 Mar 2002 10:07:43 -0500
Message-Id: <200203241507.g2OF7WN26069@ls401.hinet.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Date: Sun, 24 Mar 2002 16:07:31 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au>
Cc: Steven Walter <srwalter@yahoo.com>, Andre Pang <ozone@algorithm.com.au>
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 March 2002 08:05, you wrote:
> On Sat, Mar 23, 2002 at 10:06:47AM -0600, Steven Walter wrote:
> > > Don't get it wrong. I *do have* an VT8365. VT8365 (ProSavage KM133) is
> > > somewhat the same as VT8363 (KT133), except that 8365 has an integrated
> > > Savage graphics card (which *I use*).
> >
> > Aha... I see.  And in thinking about it, I realize that my motherboard
> > also has this integrated graphics card.  Perhaps this is the difference?
> > Unfortunately, it seems they both report the same PCI id, so I don't
> > really know of a way to differentiate them.
>
> I can verify Danijel's report -- I have the same setup
> (VT8363+VT8353, a.k.a. ProSavage KM133), and I experience the

Actually the *northbridge is VT8365* (ProSavage KM133), while it can be 
combined with other southbridges like VIA VT86c686A or VT86c686B (I'm using 
the B one.) VT8363 (KT133) is a similar chipset to KM133, and the only 
difference should be the integrated Savage graphics card in KM133.

> same screen corruption.  Clearing only bit 7 of register 55 fixes

Well, we're not the only ones with this problem. BTW, which motherboard do 
you have? Maybe it's a mainboard failure (mine is a MSI MS-6340M V1). I know 
one more Linux user with this problem on the same M/B.

> the problem; clearing bits 5 and 6 causes the video to go all
> borky.  There's been another thread about it on lkml over the
> last week or so.
>
> > I looked at that datasheet, and the datasheet for the 8363.  Both said
> > not to program offset 55, and both said the bits we are clearing are
> > "reserved."  Perhaps we should contact VIA directly, tell them the
> > problem we're having with their current fix, tell them our theory, and
> > ask if we're right.
>
> Heh, a VIA contact who knows what the hell that register does
> would be nice :).
>
> In the meantime, I'd probably suggest a patch which looks for
> clears only bit 7 of Rx55 if an 8363 and an 8365 is found.  I'll
> whip one up later today.

Yes, should implement some autodetection to detect VT8365 and clear only bit 
7 and include it in the kernel *as soon as possible* (I don't have any kernel 
programming experience, so don't ask me to do so, although it should be 
something trivial ;))

BTW, find KM133 and KT133 datasheets here ;)
	* VT8363: http://www.fae.com.tw/datasheet/8363kt/DS8363040.pdf
	* VT8365: http://www.fae.com.tw/datasheet/8365/DS8365030.pdf

Regards,

Danijel
