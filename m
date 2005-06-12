Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVFLPXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVFLPXz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVFLPXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:23:55 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:7568 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261365AbVFLPXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:23:47 -0400
Date: Sun, 12 Jun 2005 09:27:02 -0600 (MDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       Linux Kernel <linux-kernel@vger.kernel.org>, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
Message-ID: <Pine.LNX.4.61.0506120926331.15684@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2005, Daniel Walker wrote:

> Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> not sure if there is any function call overhead .. So the soft replacment 
> of cli/sti is 70% faster on a per instruction level .. So it's at least 
> not any slower .. Does everyone agree on that?

Well you also have to take into account the memory access, so it's not 
always that straightforward.

	Zwane

