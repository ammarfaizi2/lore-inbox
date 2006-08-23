Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWHWJgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWHWJgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWHWJgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:36:44 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:22991 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751483AbWHWJgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:36:43 -0400
Message-ID: <44EC21A3.1040905@vmware.com>
Date: Wed, 23 Aug 2006 02:36:35 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231106.26696.ak@suse.de> <44EC1C7C.9020304@vmware.com> <200608231120.42679.ak@suse.de>
In-Reply-To: <200608231120.42679.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> I need to look at the kprobes code in more depth to answer completely.  
>> But in general, there could be a problem if DRs are set to fire on any 
>> EIP 
>>     
>
> kprobes don't use DRs

Good to know.  But int3 breakpoints can still cause horrific breakage in 
the stop_machine code.  I don't know a good way to disallow it.

Zach
