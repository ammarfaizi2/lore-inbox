Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSHPPNB>; Fri, 16 Aug 2002 11:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSHPPNB>; Fri, 16 Aug 2002 11:13:01 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:39351 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318447AbSHPPNB>;
	Fri, 16 Aug 2002 11:13:01 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208161516.TAA29782@sex.inr.ac.ru>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
To: jmorris@intercode.com.au (James Morris)
Date: Fri, 16 Aug 2002 19:16:08 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Mutt.LNX.4.44.0208170057420.1165-100000@blackbird.intercode.com.au> from "James Morris" at Aug 17, 2 01:03:20 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Well, do you think it's worth adding a spinlock for just one fcntl handler
> and the SIOCSPGRP/FIOSETOWN ioctls?

You do not have choice. Alternative is to move bkl at top level of
in dnotify.c, I do not think vfs people will be happy about this. :-)

Alexey
