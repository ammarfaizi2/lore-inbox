Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWG3NRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWG3NRu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWG3NRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:17:50 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:25553 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750833AbWG3NRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:17:49 -0400
Message-ID: <44CCB268.3080107@keyaccess.nl>
Date: Sun, 30 Jul 2006 15:21:44 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Simon White <s_a_white@email.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver model ISA bus
References: <20060730122415.A17D31CE304@ws1-6.us4.outblaze.com> <44CCB087.8030804@keyaccess.nl>
In-Reply-To: <44CCB087.8030804@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> On the other hand, if you are really dead set against loading when
> you can't immediately drive something that's up to you as well -- you
> decide when to fail the match().

Oh, forgot to mention, if vice-versa you don't mind always loading you 
don't _have_ to supply a match() method at all.

Maybe you make your port/irq/dma parameter variables in the driver 
writable through sysfs or, heaven forbid, you do autoprobing meaning 
that there's nothing left that could not be fixed while the driver is 
loaded. If you don't provide a .match, your .probe is called always 
directly.

Rene.
