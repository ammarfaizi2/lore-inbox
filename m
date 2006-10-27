Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752277AbWJ0POg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbWJ0POg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbWJ0POf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:14:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752276AbWJ0POf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:14:35 -0400
Date: Fri, 27 Oct 2006 08:14:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Gianluca Alberici <gianluca@abinetworks.biz>, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-ID: <20061027081413.04df9f7f@localhost.localdomain>
In-Reply-To: <1161959098.12281.3.camel@laptopd505.fenrus.org>
References: <1161807069.3441.33.camel@dv>
	<1161808227.7615.0.camel@localhost.localdomain>
	<20061025205923.828c620d.akpm@osdl.org>
	<1161859199.12781.7.camel@localhost.localdomain>
	<20061026090002.49b04f1b@freekitty>
	<4540E1BB.1000101@abinetworks.biz>
	<1161959098.12281.3.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 16:24:58 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> > >
> > i've found:
> > 
> > __create_workqueue
> > queue_work
> 
> 
> if you change the queue_work() calls to schedule_work() (and drop it's
> first argument) and just remove the create_workqueue() entirely, does it
> work then? (probably also need to remove destroy_workqueue() call)
> if so, that's the real solution on the ndiswrapper side...
> 
> 

Or maybe do equivalent delayed function calls by using a kthread.
