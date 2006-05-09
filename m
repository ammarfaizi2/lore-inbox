Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWEISV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWEISV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEISV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:21:28 -0400
Received: from dvhart.com ([64.146.134.43]:19939 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750899AbWEISV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:21:27 -0400
Message-ID: <4460DDA4.2010506@mbligh.org>
Date: Tue, 09 May 2006 11:21:24 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling on Xen.
References: <20060509084945.373541000@sous-sol.org> <20060509085155.177937000@sous-sol.org> <4460AC12.3000006@mbligh.org> <20060509181444.GP7834@cl.cam.ac.uk>
In-Reply-To: <20060509181444.GP7834@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Limpach wrote:
> On Tue, May 09, 2006 at 07:49:54AM -0700, Martin J. Bligh wrote:
> 
>>>+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
>>>+{
>>>+#define C(i) 
>>>HYPERVISOR_update_descriptor(virt_to_machine(&get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i]), *(u64 *)&t->tls_array[i])
>>>+	C(0); C(1); C(2);
>>>+#undef C
>>>+}
>>
>>Please just expand this or make it a real function call (static inline),
>>not a temporary macro ..
> 
> 
> Yes, I've added an inline function to do a single descriptor.
> 
> Should I change the non-xen case as well?  It was the inspiration
> for this code ;-)

If it looks anything like that, then I'd vote yes ;-)

M.

