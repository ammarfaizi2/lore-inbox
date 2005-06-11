Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVFKXnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVFKXnq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFKXnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 19:43:46 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:59063
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261850AbVFKXno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 19:43:44 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
In-Reply-To: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 12 Jun 2005 01:44:45 +0200
Message-Id: <1118533485.13312.91.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 13:51 -0700, Daniel Walker wrote:
> On Sat, 11 Jun 2005, Ingo Molnar wrote:

> Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> not sure if there is any function call overhead .. So the soft replacment 
> of cli/sti is 70% faster on a per instruction level .. So it's at least 
> not any slower .. Does everyone agree on that?

No, because x86 is not the whole universe

tglx



