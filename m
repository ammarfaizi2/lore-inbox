Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312556AbSDJJKK>; Wed, 10 Apr 2002 05:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSDJJKJ>; Wed, 10 Apr 2002 05:10:09 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:10756 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S312556AbSDJJKJ>; Wed, 10 Apr 2002 05:10:09 -0400
Date: Wed, 10 Apr 2002 11:10:01 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020410091001.GB14339@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200204092206.02376.roger.larsson@norran.net> <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Apr 2002, Andre Hedrick wrote:

> This is because there are not a proper and correct state diagram data
> handler set for ATAPI, period.  Initially the driver evolved out of PIO
> calls to the PACKET_COMMAND opcode for the ATA command set.  Since there
> has been zero updates/attempts to create a proper ATAPI/ASPI by anyone,
> you can expect PIO transactions.
> 
> Who knows once I finally have taskfile completed and the kernel fixed to
> not violate the basics of hardware atomic for storage devices, I may fix
> all of the atapi/aspi transport.  It is a real mess to grunt through all
> the docs.  However, I suspect I could get some help (co-author a
> standard's proposal) with the original author to outline and create a 500+
> page techincal referrence guide.  So if there are any companies want to
> fund such an adventure, please let me know off-line.
> 
> Understand that only in PIO can you be sure of how much data you could get
> from a device, argh it still s a pig in a poke.

How about Andrew Morton's akpm-ide patch?
http://www.zipworld.com.au/~akpm/linux/patches/2.4/2.4.18-pre9/ide-akpm.patch

-- 
Matthias Andree
