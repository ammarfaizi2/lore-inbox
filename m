Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWCVIvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWCVIvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCVIvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:51:39 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:49162 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751099AbWCVIvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:51:38 -0500
Message-ID: <44211019.60007@vmware.com>
Date: Wed, 22 Mar 2006 00:51:37 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 30/35] Add generic_page_range() function
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063805.741915000@sorel.sous-sol.org>
In-Reply-To: <20060322063805.741915000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> Add a new mm function generic_page_range() which applies a given
> function to every pte in a given virtual address range in a given mm
> structure. This is a generic alternative to cut-and-pasting the Linux
> idiomatic pagetable walking code in every place that a sequence of
> PTEs must be accessed.
>
> Although this interface is intended to be useful in a wide range of
> situations, it is currently used specifically by several Xen
> subsystems, for example: to ensure that pagetables have been allocated
> for a virtual address range, and to construct batched special
> pagetable update requests to map I/O memory (in ioremap()).
>   

This interface is great, and highly useful.  But it doesn't seem to be 
able to work on native hardware, as it doesn't support large pages.

Zach
