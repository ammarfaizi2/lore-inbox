Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVKLPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVKLPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKLPy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:54:59 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:43169 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S932396AbVKLPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:54:58 -0500
Date: Sat, 12 Nov 2005 16:54:53 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel@vger.kernel.org
Subject: start_kernel / local_irq_enable() can be very slow
Message-ID: <20051112155453.GC21291@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've noticed that the local_irq_enable() call in 
init/main.c::start_kernel() takes 0.3 .. 3.0 seconds on every boot.
(Measured using printk's around it.)

I am wondering what happens during this call (which is effectively one 
"sti"), why does it take so much time sometimes, and why does it vary so 
much, why isn't it (more) deterministic.


This is a x86 machine, I can give more details if needed.
I've observed this behaviour on a few other machines too.


Anybody any clues?
thanks,

-- 
pozsy
