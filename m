Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSHPOrW>; Fri, 16 Aug 2002 10:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318468AbSHPOrW>; Fri, 16 Aug 2002 10:47:22 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:33975 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318455AbSHPOrV>;
	Fri, 16 Aug 2002 10:47:21 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208161450.SAA29730@sex.inr.ac.ru>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
To: jmorris@intercode.com.au (James Morris)
Date: Fri, 16 Aug 2002 18:50:28 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Mutt.LNX.4.44.0208162239370.687-100000@blackbird.intercode.com.au> from "James Morris" at Aug 16, 2 11:07:22 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> All existing paths which write to the pid/uid/euid fields are protected by
> the BKL

euid? Are you about current->xxx? You jest, you read it, not write.

Well, and if you are going to say that reading is racy, then I wonder
why you started from this place, not from another users current->xxx,
which are really critical and surely cannot use bkl. :-)

> > But I daresay this is deadlock:
> 
> Yep.

Ergo, never use BKL. :-)

Alexey
