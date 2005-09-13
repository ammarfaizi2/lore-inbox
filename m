Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVIMGEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVIMGEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIMGEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:04:50 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:10918 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932331AbVIMGEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:04:49 -0400
Message-Id: <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 13 Sep 2005 08:04:40 +0200
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margitsw@t-online.de>
Subject: 2.6.13/14 x86 Makefile - Pentiums penalized ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-ID: bKgmdsZlZe1dP--G1fCi2x9lm1SuUTVhqbq3LTlhlTJ-V095ShCO0u
X-TOI-MSGID: a6c39e36-d37a-4cce-a906-26e16c6ec617
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/i386/makefile we have :
cflags-$(CONFIG_MPENTIUMII)     += -march=i686 $(call 
cc-option,-mtune=pentium2)
cflags-$(CONFIG_MPENTIUMIII)    += -march=i686 $(call 
cc-option,-mtune=pentium3)
cflags-$(CONFIG_MPENTIUMM)      += -march=i686 $(call 
cc-option,-mtune=pentium3)
cflags-$(CONFIG_MPENTIUM4)      += -march=i686 $(call 
cc-option,-mtune=pentium4)

According to the gcc 3.x doc, the -mtune is not avaliable for i686
and, indeed, with 3.3.5 no -mtune is generated/used (make V=1).

This, of course, heavily penalizes P4's (the notorious inc/dec).

Margit


