Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWIKXcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWIKXcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWIKXcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:32:42 -0400
Received: from gw.goop.org ([64.81.55.164]:25806 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965080AbWIKXcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:32:41 -0400
Message-ID: <4505F212.4040307@goop.org>
Date: Mon, 11 Sep 2006 16:32:34 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda: Initialize the PDA early, before any C code
 runs.
References: <4505E8C1.7010906@goop.org> <20060911160301.10789d6e.akpm@osdl.org>
In-Reply-To: <20060911160301.10789d6e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> What is likely to happen if the boot CPU is not CPU #0?  (iirc Voyager does
> that?)
>   

Not sure, but I think this replicates the behaviour of the original code 
(ie, INIT_THREAD_INFO initializes cpu to 0, so smp_processor_id will 
return 0).  Hm, Voyager will probably need a little patch to update the 
the PDA cpu_number properly in smp_setup_processor_id().

    J
