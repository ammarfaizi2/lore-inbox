Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUFLEE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUFLEE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 00:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUFLEE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 00:04:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:15291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264627AbUFLEE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 00:04:26 -0400
Date: Fri, 11 Jun 2004 21:00:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: herbert@gondor.apana.org.au, pavel@suse.cz, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix memory leak in swsusp
Message-Id: <20040611210059.2522e02d.akpm@osdl.org>
In-Reply-To: <40CA75CA.2030209@linuxmail.org>
References: <20040609130451.GA23107@elf.ucw.cz>
	<E1BYN8O-0008Vg-00@gondolin.me.apana.org.au>
	<20040610105629.GA367@gondor.apana.org.au>
	<20040610212448.GD6634@elf.ucw.cz>
	<20040610233707.GA4741@gondor.apana.org.au>
	<20040611094844.GC13834@elf.ucw.cz>
	<20040611101655.GA8208@gondor.apana.org.au>
	<20040611102327.GF13834@elf.ucw.cz>
	<20040611110314.GA8592@gondor.apana.org.au>
	<40CA75CA.2030209@linuxmail.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
>  We were avoiding the use of memcpy because it messes up the preempt count with 3DNow, and 
>  potentially as other unseen side effects. The preempt could possibly simply be reset at resume time, 
>  but the point remains.

eh?  memcpy just copies memory.  Maybe your meant copy_*_user()?
