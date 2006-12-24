Return-Path: <linux-kernel-owner+w=401wt.eu-S1752420AbWLXRQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbWLXRQV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWLXRQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 12:16:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44666 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbWLXRQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 12:16:20 -0500
Subject: Re: [RFC] i386: per-cpu mmconfig map
From: Arjan van de Ven <arjan@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <87lkkxz0k5.fsf@duaron.myhome.or.jp>
References: <87lkkxz0k5.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 24 Dec 2006 18:16:17 +0100
Message-Id: <1166980577.3281.1396.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-25 at 02:05 +0900, OGAWA Hirofumi wrote:
> Hi,
> 
>     [ Alternatively, we could make a per-cpu mapping area or something. Not
>       that it's probably worth it, but if we wanted to avoid all locking and
>       instead just disable preemption, that would be the way to go. --Linus ]
> 
> This patch is a draft of Linus's suggestion. This seems work for me.
> And this removes pci_config_lock in mmconfig access path, I think we
> don't need lock on this path, although we need to disable IRQ.
> 
> Comment?

Hi,

I like the idea and the implementation, I have just one concern:
Does your schema still work if the Non-Maskable-Interrupt code uses
config space? It may do that I suspect to deal with ECC memory errors ;(

Greetings,
   Arjan van de Ven 

