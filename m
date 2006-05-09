Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWEIOuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWEIOuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWEIOuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:50:09 -0400
Received: from dvhart.com ([64.146.134.43]:3043 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751403AbWEIOuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:50:00 -0400
Message-ID: <4460AC12.3000006@mbligh.org>
Date: Tue, 09 May 2006 07:49:54 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling on Xen.
References: <20060509084945.373541000@sous-sol.org> <20060509085155.177937000@sous-sol.org>
In-Reply-To: <20060509085155.177937000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
> +{
> +#define C(i) HYPERVISOR_update_descriptor(virt_to_machine(&get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i]), *(u64 *)&t->tls_array[i])
> +	C(0); C(1); C(2);
> +#undef C
> +}

Please just expand this or make it a real function call (static inline),
not a temporary macro ..
