Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTL0LPI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 06:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbTL0LPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 06:15:08 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:62187
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S265361AbTL0LPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 06:15:05 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Sat, 27 Dec 2003 22:15:01 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
References: <200312231138.21734.kernel@kolivas.org> <200312271042.55989.kernel@kolivas.org> <20031227110903.GA1413@elf.ucw.cz>
In-Reply-To: <20031227110903.GA1413@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312272215.01563.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003 22:09, Pavel Machek wrote:
> So... even on normal SMP,
> "task-on-other-cpu-slows-down-task-on-this-cpu" effect exists. Okay,
> it is not as visible as on HT machine (50% slowdown), but its
> definitely there.

Sure but I think we're getting pedantic here. The problem is really simple - a 
uniprocessor HT desktop booted in SMP mode feels half the speed while running 
setiathome (or video encoding or whatever cpu bound task) compared to booting 
it in UP mode. So, ironically, enabling the HT makes the machine feel slower 
when running multiple tasks. And there will be a heck of a lot of these in 
the future.

Con

