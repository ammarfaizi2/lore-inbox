Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbTIJPlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbTIJPlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:41:12 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:26887
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S265024AbTIJPlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:41:09 -0400
Subject: Re: How reliable is SLAB_HWCACHE_ALIGN?
From: Robert Love <rml@tech9.net>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030910081654.GA1129@llm08.in.ibm.com>
References: <20030910081654.GA1129@llm08.in.ibm.com>
Content-Type: text/plain
Message-Id: <1063208464.700.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 11:41:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 04:16, Ravikiran G Thirumalai wrote:

> Am I missing something or can there really be two objects on the same 
> cacheline even when SLAB_HWCACHE_ALIGN is specified?

No, you are right.

If your object _must_ be cache aligned, use SLAB_MUST_HWCACHE_ALIGN.

But note that this will result in cache aligning objects even if it ends
of wasting a _lot_ of space, such as when debugging is turned on.

I think we only use it for the task_struct_cachep.

	Robert Love


