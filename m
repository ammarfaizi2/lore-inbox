Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWCICeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWCICeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWCICeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:34:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161000AbWCICeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:34:12 -0500
Date: Wed, 8 Mar 2006 18:32:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add
 percpu_counter_mod_bh
Message-Id: <20060308183206.76215706.akpm@osdl.org>
In-Reply-To: <p733bhswe6j.fsf@verdi.suse.de>
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308015934.GB9062@localhost.localdomain>
	<20060307181301.4dd6aa96.akpm@osdl.org>
	<20060308202656.GA4493@localhost.localdomain>
	<20060308203642.GZ5410@kvack.org>
	<20060308210726.GD4493@localhost.localdomain>
	<20060308211733.GA5410@kvack.org>
	<20060308222528.GE4493@localhost.localdomain>
	<20060308150609.344c62fa.akpm@osdl.org>
	<p733bhswe6j.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> > 
> > x86_64 is signed 32-bit!
> 
> I'll change it. You want signed 64bit?
> 

Well it's all random at present.  Since the API is defined as unsigned I
guess it's be best to make it unsigned for now.  Later, when someone gets
down to making it signed and reviewing all the users they can flip x86_64
to signed along with the rest of the architectures.

