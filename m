Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSHGQZM>; Wed, 7 Aug 2002 12:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318398AbSHGQZM>; Wed, 7 Aug 2002 12:25:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45327 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318277AbSHGQZK>;
	Wed, 7 Aug 2002 12:25:10 -0400
Message-ID: <3D514AC1.8030503@mandrakesoft.com>
Date: Wed, 07 Aug 2002 12:28:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
References: <20020807131813.A25485@wotan.suse.de>	<200208071151.g77Bpmt19650@devserv.devel.redhat.com> 	<20020807135643.A9340@wotan.suse.de> <1028726777.18478.295.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2002-08-07 at 12:56, Andi Kleen wrote:
> 
>>Can you please shortly explain what will not be maintainable with my
>>proposal? 


> If you think you can do it all nicely with dep_ and not if then prove me
> wrong. I'd actually like to see a working clean implementation because I
> agree about the problem, I'm dubious that the cure right now is better
> than the disease


What I did in the past for alpha was go through source and add something 
like

	#if BITS_PER_LONG != 32
	#error this file is broken for 64-bits
	#endif


