Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUIPFyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUIPFyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 01:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIPFyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 01:54:15 -0400
Received: from web53606.mail.yahoo.com ([206.190.37.39]:50574 "HELO
	web53606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267535AbUIPFxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 01:53:34 -0400
Message-ID: <20040916044514.38729.qmail@web53606.mail.yahoo.com>
Date: Wed, 15 Sep 2004 21:45:14 -0700 (PDT)
From: Donald Duckie <schipperke2000@yahoo.com>
Subject: Re: snull_load insmod: unresolved symbol
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040915100527.60a05e24.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

now, i am quite confused with what was informed
because it seems that it is none from those.

here is what was done:
i compiled the snull source file on 2.4.18-sh which i
got from
http://www.oreilly.com.tw/editor_column/a138_read.html.
it was mentioned in that site that snull was compiled
with 2.4.24.

anyway, compilation with 2.4.18-sh was successful,
but upon running insmod on 2.4.18-sh, i got those
unresolved errors. 

any help/information are very  much welcome.



i have some questions though (i am not quite familiar
with the workarounds of linux):

(1)  what does it mean if the functions cannot be
found on /proc/ksyms? almost all but the "insmod:
unresolved symbol jiffies_R0da02d67" are not defined
in that file.

(2) i am cross-compiling. i also tried running "depmod
-a" prior to compilation, but depmod wrote into
/lib/modules/2.4.24, instead of
/lib/modules/2.4.18-sh. both directories exists.
do i really need to run depmod? how will i made it
update the /lib/modules/2.4.18-sh directory instead of
the /lib/modules/2.4.24 directory?

(3) and what is meant by "i need to determine which is
the case/problem and change some part of that config."
which/what config should i change? 


i am waiting for your good insights . . .
thank you very much.



--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:

> On Wed, 15 Sep 2004 04:34:34 -0700 (PDT) Donald
> Duckie wrote:
> 
> | hi!
> | 
> | has anyone ever tried compiling and running snull
> on
> | Linux2.4.18-sh?
> | 
> | i tried compiling snull(without any modification)
> on
> | Linux2.4.18-sh.
> | upon running snull_load, i got the following:
> | Using
> /lib/modules/2.4.18-sh/kernel/drivers/net/snull.
> | insmod: unresolved symbol kmalloc_R93d4cfe6
> | insmod: unresolved symbol
> skb_under_panic_R69955398
> | insmod: unresolved symbol
> register_netdev_R09e03f58
> | insmod: unresolved symbol eth_type_trans_R0a4e7a1c
> | insmod: unresolved symbol
> unregister_netdev_R98eda3f8
> | insmod: unresolved symbol printk_Rdd132261
> | insmod: unresolved symbol __udivsi3_i4
> | insmod: unresolved symbol memcpy_R11f7ce5e
> | insmod: unresolved symbol jiffies_R0da02d67
> | insmod: unresolved symbol alloc_skb_R0177038c
> | insmod: unresolved symbol softnet_data_R258cb892
> | insmod: unresolved symbol
> cpu_raise_softirq_R4d09166c
> | insmod: unresolved symbol __kfree_skb_R1741771d
> | insmod: unresolved symbol memset_R2bc95bd4
> | insmod: unresolved symbol kfree_R037a0cba
> | insmod: unresolved symbol netif_rx_R8316ccd0
> | insmod: unresolved symbol ether_setup_R586ea93a
> | insmod: unresolved symbol skb_over_panic_R4bb59969
> | 
> | can someone please tell me what's wrong with this,
> | and how to fix this without chaning Linux
> versions?
> 
> You are building the module with module versioning
> turned on,
> but your kernel is built without module versions, or
> it is built
> with module versions, but they don't match your
> current kernel
> source code.
> 
> You'll need to determine which is the case/problem
> and change
> some part of that config.
> 
> --
> ~Randy
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
