Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTKZSkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTKZSki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:40:38 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:12929 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264281AbTKZSkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:40:37 -0500
Date: Wed, 26 Nov 2003 18:40:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Kai Bankett <kbankett@aol.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_balance does not make sense with HT but single physical CPU
Message-ID: <20031126184031.GC14383@mail.shareable.org>
References: <3FC4B5C8.6020405@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FC4B5C8.6020405@aol.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Bankett wrote:
> this patch should disable irq_balance threat in case of only one 
> installed physical cpu thats running in HyperThreading-mode (so reported 
> as 2 cpus).
> I think it should make no sense to run irq_blanance in that special case 
> - please correct me if i´m wrong.

Does it makes no sense?

If you had two tasks both running continuously, one per sibling, then
not IRQ balancing will penalise the task on the sibling which is
getting most interrupts.

-- Jamie
