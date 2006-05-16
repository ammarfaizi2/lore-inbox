Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWEPRTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWEPRTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWEPRTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:19:12 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:47920 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932118AbWEPRTL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:19:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lJHWi4vRIWah4pKsaP6SsjXxBJ+sjeZtO1USUAViBcPpevoT4cwIqm9WxYclId+SmvWmkb1SrsOV8yg/GhY3cF9KuWU2gQQ79Fwx5WZ+SDybVdbKzi520n8ezwp/2ovDC0vGNsp86/n2/NJQMngFUcyfpb4yMfYyFqtfSs16iyY=
Message-ID: <3b0ffc1f0605161019j7149f72bv309db19eb9d12dd8@mail.gmail.com>
Date: Tue, 16 May 2006 13:19:11 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Fix broken PIO with libata
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147794791.2151.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147790393.2151.62.camel@localhost.localdomain>
	 <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>
	 <1147794791.2151.71.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-05-16 at 11:33 -0400, Kevin Radloff wrote:
> > However, I still have a problem with pata_pcmcia (that I actually
> > experienced also with the ide-cs driver) where sustained reading or
> > writing to the CF card spikes the CPU with nearly 100% system time.
>
> That is normal. The PCMCIA devices don't support DMA. As a result of
> this the processor has to fetch each byte itself over the ISA speed
> PCMCIA bus link.

Hrm, as I recall that only started happening with ide-cs sometime in
the single digits of 2.6.x.. And note that it's only maxing out at
about 1.5MB/s. Should that saturate my laptop's 1.1GHz Pentium M
processor?

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
