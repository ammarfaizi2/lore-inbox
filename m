Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSL3Uxj>; Mon, 30 Dec 2002 15:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSL3Uxj>; Mon, 30 Dec 2002 15:53:39 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:15257 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S262210AbSL3Uxj> convert rfc822-to-8bit; Mon, 30 Dec 2002 15:53:39 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
To: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Date: Mon, 30 Dec 2002 22:00:37 +0100
User-Agent: KMail/1.4.3
References: <4.3.2.7.2.20021230212528.00b5fc80@pop.t-online.de>
In-Reply-To: <4.3.2.7.2.20021230212528.00b5fc80@pop.t-online.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212302200.37424.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>          Sorry, the patch doesn't change anything.
>          I am compiling with PREEMPT off.
>          Looking at sysrq.c , I would say that a couple of
>          #ifdef's are missing. The code in the handle_preempt
>          function, I think should be ifdef'd on CONFIG_PREEMPT_LOG
>
>          Margit

Hi Margit,

you should enable preemptive kernel logging only if you selected preemptive 
kernel.

In the case of preempt logging turned off, the show_preempt_log() function 
should evaluate to an empty function

#define show_preempt_log()	do { } while(0)

as defined in <linux/sched.h>

Best regards,

Jörg

