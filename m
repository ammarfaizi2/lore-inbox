Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUHCSrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUHCSrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266797AbUHCSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:47:12 -0400
Received: from watson.wustl.edu ([128.252.233.1]:46511 "EHLO watson.wustl.edu")
	by vger.kernel.org with ESMTP id S265141AbUHCSrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:47:07 -0400
Message-ID: <54073.10.0.1.211.1091558826.squirrel@10.0.1.211>
In-Reply-To: <1091554289.3898.5.camel@localhost.localdomain>
References: <4107E4B3.6070904@watson.wustl.edu> 
    <20040803180821.GB6265@logos.cnet>
    <1091554289.3898.5.camel@localhost.localdomain>
Date: Tue, 3 Aug 2004 13:47:06 -0500 (CDT)
Subject: Re: dma problems with Serverworks CSB5 chipset
From: "Rich Wohlstadter" <rwohlsta@watson.wustl.edu>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Bartlomiej Zolnierkiewicz" <b.zolnierkiewicz@elka.pw.edu.pl>
Reply-To: rwohlsta@watson.wustl.edu
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.6; VAE: 6.26.0.10; VDF: 6.26.0.57; host: watson.wustl.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Maw, 2004-08-03 at 19:08, Marcelo Tosatti wrote:
>> ServerWorks OSB4/5 chipsets are known to not work reliably with the
>> Linux
>> IDE code. AFAIK its a hardware problem which we dont correctly work
>> around.
>>
>> Have you tried disabling DMA?
>>
>> Bart and Alan are IDE experts, they can probably give you more useful
>> information.
>
> CSB5 is reliable, rock solidly so in my experience. OSB4 was the older
> interface with problems. Are these systems SMP, what disks are you using
> and in what IDE mode ?
>

Yep, they are SMP(IBM blades with 2 Xeon 2.4Ghz).  The blades use 1
little 40g laptop drive( TOSHIBA MK4019GAXB ).  The drive is running UDMA
mode 4.  Here is the output of /proc/ide/svwks:

                             ServerWorks OSB4/CSB5/CSB6

                            ServerWorks CSB5 Chipset (rev 93)
------------------------------- General Status
---------------------------------
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------
DMA enabled:    yes              yes             no                no
UDMA enabled:   yes              yes             no                no
UDMA enabled:   4                4               0                 0
DMA enabled:    2                2               2                 2
PIO  enabled:   4                4               ?                 ?

Let me know if you need any other specifics and thanks in advance for any
advice.

Rich

