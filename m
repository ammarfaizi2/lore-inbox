Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbTI2KsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 06:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTI2KsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 06:48:15 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:19418 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262954AbTI2KsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 06:48:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16248.3563.675576.448898@gargle.gargle.HOWL>
Date: Mon, 29 Sep 2003 12:48:11 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5, gcc 3.3, aic7(censored)_core.c
In-Reply-To: <2ff401c38611$5ef13d20$44ee4ca5@DIAMONDLX60>
References: <2ff401c38611$5ef13d20$44ee4ca5@DIAMONDLX60>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond writes:
 > In 2.6.0-test5, the README still says "Make sure you have gcc 2.95.3
 > available."  It is telling the truth.
 > 
 > SuSE 8.2 includes gcc 3.3 20030226 (prerelease).  Up to the point of
 > aborting, it diagnoses a ton of "warning: comparison between signed and
 > unsigned", but nonetheless compiles many source files and continues.  But in
 > aic7(censored)_core.c, line 76, it diagnoses "warning: `num_chip_names'
 > defined but not used".  Even though this is also just a warning, obviously
 > it threatens disastrous consequences  :-s  (sarcasm).  make[3] quits with
 > Error 1 and make[2] and make[1] quit with Error 2.

Look for and delete any -Werror in aic7xxx' Makefile.
I've seen people being bit by this before.
