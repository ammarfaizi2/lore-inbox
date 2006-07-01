Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWGAJd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWGAJd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWGAJd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:33:56 -0400
Received: from www.osadl.org ([213.239.205.134]:15776 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932542AbWGAJdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:33:55 -0400
Subject: Re: Q: locking mechanisms
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Urs Thuermann <urs@isnogud.escape.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2odw9g937.fsf@janus.isnogud.escape.de>
References: <m2odw9g937.fsf@janus.isnogud.escape.de>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 11:36:11 +0200
Message-Id: <1151746571.25491.850.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urs,

On Sat, 2006-07-01 at 07:58 +0200, Urs Thuermann wrote:
> So my question is, is it really necessary for the list traversal to be
> atomic, i.e. to disable preemption?  According to "Linux Device
> Drivers", this is needed for the callback function, so it can be
> called after the scheduler has been run on all CPUs and no reader is
> still accessing the list item to be freed.  Is it right, that the
> rcu_read_lock() wouldn't be necessary if I only would call
> list_add_rcu() and list_del_rcu() since these make atomic changes and
> can run in parallel anyway, even with rcu_read_lock(), on a SMP
> system?

Does Documentation/listRCU.txt answer your questions ?

	tglx


