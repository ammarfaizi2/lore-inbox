Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUIVEzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUIVEzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 00:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUIVEzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 00:55:15 -0400
Received: from peabody.ximian.com ([130.57.169.10]:42884 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263448AbUIVEzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 00:55:10 -0400
Subject: Re: Does ZONE_HIGHMEM exist on machines with 1G memeory
From: Robert Love <rml@novell.com>
To: Ronghua Zhang <rz5b@cs.virginia.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.51.0409220035500.8395@mamba.cs.Virginia.EDU>
References: <Pine.GSO.4.51.0409212305520.8395@mamba.cs.Virginia.EDU>
	 <1095826387.2454.101.camel@localhost>
	 <Pine.GSO.4.51.0409220035500.8395@mamba.cs.Virginia.EDU>
Content-Type: text/plain
Date: Wed, 22 Sep 2004 00:55:10 -0400
Message-Id: <1095828910.2454.124.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 00:39 -0400, Ronghua Zhang wrote:

> But why cannot we simply map the whole physical memory into the 1GB
> kernel virtual address space? In this case, we don't need to reserve any
> address space for the permanent or temporary mapping. Am I missing
> something here? Thanks

It is because of how the mappings work and where PAGE_OFFSET is.

With some hacking you can definitely use all 1GB without HIGHMEM, but
you would not be able to use more than 1GB.  And it would break ABI, at
least for modules.

	Robert Love


