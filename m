Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWEPSNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWEPSNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWEPSNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:13:35 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:27833 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932479AbWEPSNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:13:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cKa9HS5eLBBHoKFqDPDljjlvPDVeKRx3sX/OwW+YXT83mLwKRo0dpN7Kz3X/oOHAOveHN3IM6MDu0InaQMuzizVK5fdtrGy9eDtcuxWF7MZKyV8GVpaKklkMV4iVazlDaJovhc4elyM6FxhxItG/GlR75rM/1xDsYnqNYfpU/OI=
Message-ID: <3b0ffc1f0605161113j321e1e36l9de8bf6eacbc0b49@mail.gmail.com>
Date: Tue, 16 May 2006 14:13:31 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Tejun Heo" <htejun@gmail.com>
Subject: Re: PATCH: Fix broken PIO with libata
Cc: "Jeff Garzik" <jeff@garzik.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <446A0E36.5060505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147790393.2151.62.camel@localhost.localdomain>
	 <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>
	 <1147794791.2151.71.camel@localhost.localdomain>
	 <3b0ffc1f0605161019j7149f72bv309db19eb9d12dd8@mail.gmail.com>
	 <446A0B6C.8050901@garzik.org> <446A0E36.5060505@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/06, Tejun Heo <htejun@gmail.com> wrote:
> Jeff Garzik wrote:
> > Kevin Radloff wrote:
> >> On 5/16/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >>> On Maw, 2006-05-16 at 11:33 -0400, Kevin Radloff wrote:
> >>> > However, I still have a problem with pata_pcmcia (that I actually
> >>> > experienced also with the ide-cs driver) where sustained reading or
> >>> > writing to the CF card spikes the CPU with nearly 100% system time.
> >>>
> >>> That is normal. The PCMCIA devices don't support DMA. As a result of
> >>> this the processor has to fetch each byte itself over the ISA speed
> >>> PCMCIA bus link.
> >>
> >> Hrm, as I recall that only started happening with ide-cs sometime in
> >> the single digits of 2.6.x.. And note that it's only maxing out at
> >> about 1.5MB/s. Should that saturate my laptop's 1.1GHz Pentium M
> >> processor?
> >
> > Doing data xfer using PIO rather than DMA definitely eats tons of CPU
> > cycles.
>
> Yeap, in addition, if doing real PIO (unbuffered by the HBA), the time
> it takes is soley determined by what PIO mode is in use.  It doesn't
> matter how fast the CPU is.  Faster CPUs only end up wasting more
> cycles.  :-(

(oops, hit 'reply', but given the incredible importance of my response... ;P)

Ah, well then never mind. ;) I just have a dim memory of it being
different a long time ago. At least it works now. :D

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
