Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268740AbTBZNIK>; Wed, 26 Feb 2003 08:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268741AbTBZNIK>; Wed, 26 Feb 2003 08:08:10 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:61326 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268740AbTBZNIK>; Wed, 26 Feb 2003 08:08:10 -0500
Date: Wed, 26 Feb 2003 08:18:14 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302261318.h1QDIE4x004103@locutus.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: [ATM] suni_init declared __init AND exported?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


currently suni_init() in drivers/atm/suni.c is declared as 

int __init suni_init(struct atm_dev *dev)
{
}
EXPORT_SYMBOL(suni_init);

with 2.4 kernels this works fine since __init goes away for
modules.  however this seems to be a problem for 2.5 since
suni_init will be discarded after the suni module is loaded.
atm drivers calling suni_init() during their startup/load
oops since the suni_init() function is no longer available.

the __init should go away right?
