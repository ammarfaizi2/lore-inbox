Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWHKGiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWHKGiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWHKGiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:38:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16555
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932114AbWHKGiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:38:17 -0400
Date: Thu, 10 Aug 2006 23:38:26 -0700 (PDT)
Message-Id: <20060810.233826.24610567.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: drepper@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, zach.brown@oracle.com
Subject: Re: [take6 1/3] kevent: Core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060811063353.GC11230@2ka.mipt.ru>
References: <20060811061535.GA11230@2ka.mipt.ru>
	<44DC22C1.1060200@redhat.com>
	<20060811063353.GC11230@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Fri, 11 Aug 2006 10:33:53 +0400

> That requires mmap hacks to substitute pages in run-time without user
> notifications. I do not expect it is a good solution, since on x86 it
> requires full TLB flush (at least when I did it there were no exported
> methods to flush separate addresses).

You just need to provide a do_no_page method, the VM layer will
take care of the page level flushing or whatever else might be
needed.

