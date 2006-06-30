Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWF3U5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWF3U5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWF3U5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:57:12 -0400
Received: from ara.aytolacoruna.es ([195.55.102.196]:36774 "EHLO
	mx.aytolacoruna.es") by vger.kernel.org with ESMTP id S932400AbWF3U5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:57:08 -0400
Date: Fri, 30 Jun 2006 22:57:03 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: awe64 isa pnp ALSA problems since 2.6.17
Message-ID: <20060630205703.GA2840@pul.manty.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm experiencing some problems on 2.6.17 that I didn't have on 2.6.16, most
noticeable are the messages when alsa is loaded:

setup_irq: irq handler mismatch
 <c012387b> setup_irq+0xe5/0xfb  <c01bfc95> pnp_test_handler+0x0/0x6
 <c01238fc> request_irq+0x6b/0x8b  <c01bfe55> pnp_check_irq+0xb8/0x12f
 <c01bfc95> pnp_test_handler+0x0/0x6  <c01c083b> pnp_assign_irq+0xd7/0xf4
 <c01c0acd> pnp_assign_resources+0x1bc/0x23a  <c01c0bac>
pnp_auto_config_dev+0x6
1/0x8f
 <c01c0bf9> pnp_activate_dev+0x1f/0x46  <d08de81b>
snd_sb16_pnp_detect+0x1ae/0x3
4f [snd_sbawe]
 <c01bf3d5> card_probe+0xb1/0x104  <c01bf4a8>
pnp_register_card_driver+0x80/0x90
 <d085a070> alsa_card_sb16_init+0x70/0xae [snd_sbawe]  <c01223ba>
sys_init_modul
e+0x1103/0x1272
 <c01024b3> syscall_call+0x7/0xb 
pnp: Device 00:01.00 activated.
pnp: Device 00:01.02 activated.

before this messages isapnp is initialiced without any problem with this
messages:

isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total

As I said this is only happening on 2.6.17 and not on 2.6.16, also some
programs still using the oss api are sounding really bad now (I noticed this
on skype, but not on kiax or mpg123).

Machine is a pentium III with a via apollo mvp3 chipset.

I don't know what else to add, don't hesitate to ask for any other details
or for any tests you'd like.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
