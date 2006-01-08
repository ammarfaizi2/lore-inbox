Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWAHAXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWAHAXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWAHAXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:23:08 -0500
Received: from xenotime.net ([66.160.160.81]:39400 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030501AbWAHAXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:23:08 -0500
Date: Sat, 7 Jan 2006 16:23:05 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bunk@stusta.de, mark.fasheh@oracle.com, kurt.hackel@oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] OCFS2: __init / __exit problem
Message-Id: <20060107162305.30779b5b.rdunlap@xenotime.net>
In-Reply-To: <1136670678.2936.46.camel@laptopd505.fenrus.org>
References: <20060107132008.GE820@lug-owl.de>
	<20060107190702.GT3774@stusta.de>
	<20060107213821.GD3313@ca-server1.us.oracle.com>
	<20060107214947.GW3774@stusta.de>
	<1136670678.2936.46.camel@laptopd505.fenrus.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2006 22:51:17 +0100 Arjan van de Ven wrote:

> 
> > 
> > This is the common problem that such error paths are only used once 
> > every dozen years and therefore get no real testing coverage...
> 
> 
> Rusty presented some brilliant tool for this at OLS this year... I bet
> that could be used for filesystems as well (Rusty uses it for netfilter
> testing)

this year?

New drivers/filesystems should get treatment such as:

1.  build cleanly, no compile/link warnings
2.  check with sparse, eliminate its warnings
3.  use 'make checkstack buildcheck namespacecheck'
    and fix their problems

similar to what I recently did on the Areca/arcmsr driver
and on libata-acpi additions.

---
~Randy
