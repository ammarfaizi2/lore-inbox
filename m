Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSGaJwp>; Wed, 31 Jul 2002 05:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSGaJwp>; Wed, 31 Jul 2002 05:52:45 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:7677 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317876AbSGaJwp>; Wed, 31 Jul 2002 05:52:45 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020730225736.K7677@flint.arm.linux.org.uk> 
References: <20020730225736.K7677@flint.arm.linux.org.uk>  <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Fix suspend of the kseriod thread 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jul 2002 10:55:54 +0100
Message-ID: <9658.1028109354@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  Isn't interruptible_sleep_on() taboo? 

With the demise of cli() and the continued removal of the BKL, all users of 
sleep_on() are probably buggy. We should remove it completely.

--
dwmw2


