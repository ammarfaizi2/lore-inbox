Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSKZUFK>; Tue, 26 Nov 2002 15:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbSKZUDU>; Tue, 26 Nov 2002 15:03:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8360 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266805AbSKZUDM>;
	Tue, 26 Nov 2002 15:03:12 -0500
Subject: [PROBLEM] linux-2.4.20-rc3: ksoftirqd_CPU0 eats cpu and locks
	orinoco driver
From: john stultz <johnstul@us.ibm.com>
To: hermes@gibson.dropbear.id.au
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1038341374.960.41.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 26 Nov 2002 12:09:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an FYI. 

I built 2.4.20-rc3 w/ the hermes/orinoco wireless ethernet driver (ver:
0.11b from in-kernel source). Everything would work fine until I started
putting load on the network card. ksoftirqd_CPU would then peg the cpu
usage to 100%, and the network connection would die. Popping the card
out immediately would stop ksoftirqd from going crazy and everything
would carry on fine (re-inserting the card, light network traffic, etc).
I built and installed the orinoco-0.13beta1 code and that solved the
problem. 

Might a re-sync be considered before 2.4.20-final?

thanks
-john


