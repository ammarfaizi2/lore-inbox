Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbUCITDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbUCITDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:03:33 -0500
Received: from palrel10.hp.com ([156.153.255.245]:24752 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262090AbUCITD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:03:28 -0500
Date: Tue, 9 Mar 2004 11:03:26 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@pobox.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: IrDA patches : Stephen strikes again !
Message-ID: <20040309190326.GA14543@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Dave,

	It seems that Stephen will never stop picking fixing the IrDA
stack. He must be addicted. Anyway, here is the result of his latest
work, migrating all the EXPORT_SYMBOL() close to their symbol.
	Those patches are all very trivial and tested here. Would you
mind pushing that to Linus ?

	Regards,

	Jean

-----------------------------------------------------------------------

ir264_irsyms_01_proc.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(1/14) irda exports proc_irda

Move proc_irda out of irsyms.c into irproc.c

ir264_irsyms_02_irtty.diff
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(2/14) flush old irtty exports   

These irtty symbols were exported but never used!

ir264_irsyms_03_hashbin.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(3/14) hashbin export symbols

Move hashbin_X exports out of irsyms and into irqueue.

ir264_irsyms_04_irttp.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(4/14) irttp exports

Move irttp_exports out of irsyms

ir264_irsyms_05_irias.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(5/14) irias exports

Move iriap_reoutines out of irsyms
Rename variable "missing" to irias_missing

ir264_irsyms_06_irlmp.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(6/14) irlmp exports and inline

Move irlmp routines out irsyms.   
Make get_saddr and get_daddr inline
Rename lmp_reasons to irlmp_reasons

ir264_irsyms_07_wrapper.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(7/14) wrap function exports   

Move async_wrap function exports out of irsyms

ir264_irsyms_08_crc.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(8/14) crc16 symbol exports   

Move crc16 exports out of irsyms. Make type __u16 rather than
unsigned short to match input parameter.

ir264_irsyms_09_timer.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(9/14) irda_start_timer inline

Make irda_start_timer inline rather than exporting, because
it probably takes more code to call than just put inline

ir264_irsyms_10_irlap.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(10/14) irlap symbol exports   

Move irlap exports out of irsyms

ir264_irsyms_11_device-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(11/14) irda_device inlines and symbols   

Make irda_get_mtt, et all inline's not #defines for better
type checking.

irda_device_setup can now be static only called from alloc_irdadev

ir264_irsyms_12_qos.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(12/14) qos symbol exports

Move qos related exports out of irsyms

ir264_irsyms_13_param.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(13/14) irda_param symbol exports

Move irda_param related exports out of irsyms

ir264_irsyms_14_irmod.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
(14/14) move last of irsyms.c to irmod.c

Move last bits of code out of irsyms and onto irmod.c where
initialization happens.

Move irda_debug parameter out of irsyms.c into irmod.c
and make it a new style module parameter.

Removes file net/irda/irsyms.c completely; check this in case mailer
seems to barf on the line the character in University of Tromso

