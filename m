Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263189AbUJ2JvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbUJ2JvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbUJ2JvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:51:06 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:33740 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S263189AbUJ2JuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:50:09 -0400
Message-ID: <41821250.70502@verizon.net>
Date: Fri, 29 Oct 2004 05:50:08 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Jez <dave.jez@seznam.cz>
CC: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz> <20041029081848.GA5240@stud.fit.vutbr.cz>
In-Reply-To: <20041029081848.GA5240@stud.fit.vutbr.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.211.53] at Fri, 29 Oct 2004 04:50:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Jez wrote:
>   Hi all,
> 
>   Last night i solved this problem. It cause by crippled PCI chipset
> parody called ALi and his perverse undocumented "features". I think that
> use ISA bridge as IRQ router if we haven't any router is guite good idea.
>   Everythink with this patch works fine even though i have different irq in
> win. See attached logs.
>   Jim, can you try this patch please? I assume that you have some kind
> of ALi chipset too. Maybe this solves your problem too.
>   Martin, Marcelo, please aply :-).
> 
> PS: is here anybody who have relevant datascheet?
> 
>   Regards,
> 
> 

Naah.  I have a piix chipset.  My problem (per David Hinds) is that my laptop is 
even more b0rken than yours - IBM never hooked up the PCI INTx lines on the TI 
1130.  My laptop never worked with Cardbus stuff - even in Windows.

He reccommended the external pcmcia_cs package for my system - there's a dummy_cs 
module in there (2.4 only, though) that should fix my problem.

Thanks,

Jim
