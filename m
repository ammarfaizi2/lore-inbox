Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUCHXLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUCHXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:11:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:48285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261401AbUCHXKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:10:36 -0500
Date: Mon, 8 Mar 2004 15:09:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kliment Yanev <Kliment.Yanev@helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-Id: <20040308150907.4db68831.rddunlap@osdl.org>
In-Reply-To: <404CF77A.2050301@helsinki.fi>
References: <40408852.8040608@helsinki.fi>
	<20040228104105.5a699d32.rddunlap@osdl.org>
	<40419A1C.5070103@helsinki.fi>
	<20040301101706.3a606d35.rddunlap@osdl.org>
	<404C8A35.3020308@helsinki.fi>
	<20040308090640.2d557f9e.rddunlap@osdl.org>
	<404CF77A.2050301@helsinki.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2004 00:45:14 +0200 Kliment Yanev wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| 
| 
| Randy.Dunlap wrote:
| 
| | |
| | | I compared the orinoco_cs drivers in 2.4 and 2.6 and I updated the nokia
| | | driver source. However now I get "-1 unknown symbol in module" when I
| | | try to insmod the module... where should I start troubleshooting?
| |
| | Set the console loglevel to 9 so that you can see all of the
| | kernel messages and then try to reload the module.  Some explanatory
| | error message should appear to indicate the problem area.
| |
| 
| dmesg handled that. dmesg output below (there was also an
| "unknown symbol CardServices" but I fixed that bu replacing all
| references to CardServices with the pcmcia_functionname functions.
| What are the replacements for these then? (The license string I can
| correct myself)
| 
| nokia_c110: module license 'unspecified' taints kernel.
| nokia_c110: Unknown symbol dcfg_new
| nokia_c110: Unknown symbol dllc_register
| nokia_c110: Unknown symbol dllc_delete
| nokia_c110: Unknown symbol dfree
| nokia_c110: Unknown symbol ddev_register
| nokia_c110: Unknown symbol dmgr_pcmcia_action
| nokia_c110: Unknown symbol dcfg_delete
| nokia_c110: Unknown symbol dmgr_new
| nokia_c110: Unknown symbol dllc_new
| nokia_c110: Unknown symbol dprintk
| nokia_c110: Unknown symbol dllc_set_my_mac_addr
| nokia_c110: Unknown symbol dmgr_delete
| nokia_c110: Unknown symbol ddev_unregister
| nokia_c110: Unknown symbol dhw_get_my_mac
| nokia_c110: Unknown symbol dhw_delete
| nokia_c110: Unknown symbol dhw_new
| nokia_c110: Unknown symbol dhw_ISR

I have no idea where these symbols live or come from.

You know, it's possible that you could purchase a card that already
works on Linux 2.6.... that might be a better solution than trying
to use an unknown binary module.

--
~Randy
