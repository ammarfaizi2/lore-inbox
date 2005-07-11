Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVGKPMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVGKPMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGKPJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:09:34 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:57515 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261958AbVGKPJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:09:25 -0400
Message-ID: <42D28DE4.B5B17853@tv-sign.ru>
Date: Mon, 11 Jul 2005 19:19:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] i386: Per node IDT
References: <42D26604.66A75939@tv-sign.ru> <Pine.LNX.4.61.0507110747480.16055@montezuma.fsmlabs.com> <42D285CD.CF9389F8@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> Probably it makes sense to change it to
>         pushl $vector - 0xFFFF - 1
> 

Please note that entry.S:BUILD_INTERRUPT() also does this trick:
	pushl $nr-256;

so it should be changed as well.

Oleg.
