Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSHPJ4g>; Fri, 16 Aug 2002 05:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318275AbSHPJ4g>; Fri, 16 Aug 2002 05:56:36 -0400
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:33780
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S318266AbSHPJ4g>; Fri, 16 Aug 2002 05:56:36 -0400
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: henrique@cyclades.com
cc: linux-kernel@vger.kernel.org
Message-ID: <80256C17.00376E92.00@notesmta.eur.3com.com>
Date: Fri, 16 Aug 2002 11:00:00 +0100
Subject: Re: Problem with random.c and PPC
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>BTW, does anyone know where I can found the patch to get randomness from the
>network cards interrupt ?

Add the flag SA_SAMPLE_RANDOM into the request_irq() flags in the driver for
whichever interrupt source you want to use
e.g. from drivers/net/3c523.c

     ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM,
                 dev->name, dev);


     Jon


