Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTANJNQ>; Tue, 14 Jan 2003 04:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbTANJNQ>; Tue, 14 Jan 2003 04:13:16 -0500
Received: from m3.net81-67-40.noos.fr ([81.67.40.3]:51091 "EHLO
	jibboom.dyns.cx") by vger.kernel.org with ESMTP id <S261868AbTANJNP>;
	Tue, 14 Jan 2003 04:13:15 -0500
Date: Tue, 14 Jan 2003 10:22:07 +0100
From: Hugo Haas <hugo@larve.net>
To: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Cc: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug report : i810_audio, compaq evo 410c, 2.4.20
Message-ID: <20030114092207.GB24242@home.larve.net>
Mail-Followup-To: Hugo Haas <hugo@larve.net>,
	Nicolas Turro <Nicolas.Turro@sophia.inria.fr>,
	Soeren Sonnenburg <kernel@nn7.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1042497413.1223.21.camel@sun> <200301141002.56498.Nicolas.Turro@sophia.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301141002.56498.Nicolas.Turro@sophia.inria.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nicolas Turro <Nicolas.Turro@sophia.inria.fr> [2003-01-14 10:02+0100]
> > I saw that someone said he got it working, see:
> >  http://larve.net/people/hugo/2002/12/evo410
> 
> 
> I already contacted Hugo, in fact, he didn't manage to make the sound working 
> either.
> 
> > But I could not find out how.

I got reports from two people who said that they got it working.

One of them (I haven't updated my page yet) said that the Evo N410c
was "using a variant of the AD1886 (the AD1886A)" and that 2.4.19's
ac97_codec.c could be modified to add to ac97_codec_ids:

  { 0x41445363 ,"Analog Devices AD1886A", &null_opts },

and then it works with:

  modprobe i810_audio clocking=41194

Nicolas tried this, as he reported, with 2.4.20 and said that it was
still crashing. I haven't played with this myself yet.

Regards,

Hugo

-- 
Hugo Haas - http://larve.net/people/hugo/
