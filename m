Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVFKRNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVFKRNr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVFKRNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:13:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62714 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261748AbVFKRNo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:13:44 -0400
Date: Sat, 11 Jun 2005 10:13:27 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>
cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <42AB1712.3080301@kolumbus.fi>
Message-ID: <Pine.LNX.4.10.10506111011470.27294-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, [UTF-8] Mika Penttilä wrote:
> The timer irq is run as NODELAY, so soft irqs are run against 
> local_irq_disable sections all the time.

Softirq's are run in threads . The wake_up_process() path is protected,
and used by the timer interrupt .


Daniel

