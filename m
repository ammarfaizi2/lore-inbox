Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSJ2Wlf>; Tue, 29 Oct 2002 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262437AbSJ2Wle>; Tue, 29 Oct 2002 17:41:34 -0500
Received: from holomorphy.com ([66.224.33.161]:51684 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262430AbSJ2Wle>;
	Tue, 29 Oct 2002 17:41:34 -0500
Date: Tue, 29 Oct 2002 14:47:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Erich Focht <efocht@ess.nec.de>, davidm@hpl.hp.com,
       linux-ia64 <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Re: [PATCH] topology for ia64
Message-ID: <20021029224725.GH23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Erich Focht <efocht@ess.nec.de>, davidm@hpl.hp.com,
	linux-ia64 <linux-ia64@linuxia64.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200210051904.22480.efocht@ess.nec.de> <15796.38594.516266.130894@napali.hpl.hp.com> <200210221123.37145.efocht@ess.nec.de> <3DBF096D.6080703@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBF096D.6080703@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 02:19:25PM -0800, Matthew Dobson wrote:
+/*
+ * Returns the number of the first CPU on Node 'node'.
+ * Slow in the current implementation.
+ * Who needs this?
+ */
+/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
+static inline int __node_to_first_cpu(int node)

So far so safe... though no obvious use of it.


On Tue, Oct 29, 2002 at 02:19:25PM -0800, Matthew Dobson wrote:
> No one is using it now.  I think that I will probably deprecate this 
> function in the near future as it is pretty useless.  Anyone looking for 
> that functionality can just do an __ffs(__node_to_cpu_mask(node)) 
> instead, and hope that there is a reasonably quick implementation of 
> __node_to_cpu_mask.

This assumes the value returned by __node_to_cpu_mask() is a single word.


Bill
