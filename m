Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289749AbSAOXVa>; Tue, 15 Jan 2002 18:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289748AbSAOXVS>; Tue, 15 Jan 2002 18:21:18 -0500
Received: from jalon.able.es ([212.97.163.2]:5113 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289741AbSAOXVE>;
	Tue, 15 Jan 2002 18:21:04 -0500
Date: Wed, 16 Jan 2002 00:26:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.4.14 on alpha
Message-ID: <20020116002642.A1838@werewolf.able.es>
In-Reply-To: <20020114212550.A17323@animx.eu.org> <20020115113213.A1539@werewolf.able.es> <20020115115530.A19073@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020115115530.A19073@animx.eu.org>; from wakko@animx.eu.org on mar, ene 15, 2002 at 17:55:30 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020115 Wakko Warner wrote:
>> >arch/alpha/kernel/kernel.o(.exitcall.exit+0x0): undefined reference to `local symbols in discarded section .text.exit'
>> 
>> Too bew binutils. .17 works again.
>
>Are you saying that 2.4.17 works but prior doesn't?  or were you refering to
>binutils.
>

Recent binutils warn about symbols marked as discardable but referenced
when the driver is built-in instead of modularized. Older ones just shut up.

Original explanation:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100753194504523&w=2

Corrected mainly in 2.4.17-pre6 (and some leftovers in following pres).
>From ChangeLog-2.4.17:

pre6:
...
- Create __devexit_p() function and use that on 
  drivers which need it to make it possible to
  use newer binutils                (Keith Owens)
...

>Please keep the CC to linux-kernel as my spam filter is tagging your mail
>server =(
>

OK.

My ISP has reached the spam-black-lists ? I'm beginning to think that
those lists are becoming useless. Everybody is there. Some day someone
will manage to send just ONE message faking vger and the linux kernel
list will be banned...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre3-beo #5 SMP Sun Jan 13 02:14:04 CET 2002 i686
