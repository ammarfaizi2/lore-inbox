Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291394AbSBXVf6>; Sun, 24 Feb 2002 16:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSBXVfs>; Sun, 24 Feb 2002 16:35:48 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:36879 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S291394AbSBXVfe>; Sun, 24 Feb 2002 16:35:34 -0500
Date: Sun, 24 Feb 2002 22:35:33 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
Subject: HZ value used in kernel/acct.c
Message-ID: <Pine.LNX.4.33.0202242217070.30805-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the supposed unit of the ac_etime field of struct acct?
The code in kernel/acct.c currently says

   ac.ac_etime = encode_comp_t(jiffies - current->start_time);

so it is given in multiples of HZ, which makes this value 
platform-dependent (and subject of overflow after 48.5 days with HZ=1024). 
In include/linux/acct.h however there is the definition

   #define AHZ             100

which somehow smells like the preferred time unit.
Comments?

Tim

