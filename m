Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWDTHpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDTHpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 03:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWDTHpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 03:45:23 -0400
Received: from mail.suse.de ([195.135.220.2]:62666 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750757AbWDTHpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 03:45:22 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU
References: <20060419094630.GA14800@elte.hu> <20060420052954.GA5524@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 20 Apr 2006 09:45:16 +0200
In-Reply-To: <20060420052954.GA5524@elte.hu>
Message-ID: <p73hd4o3d2r.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> 
> but ... a more fundamental question is, where does the SMP-alternatives 
> code flush the icache? I dont think it's generally guaranteed on x86 
> CPUs that MESI updates to code get propagated into the icache of other 
> CPUs/cores.

Are you sure? I thought it was. Of course there can be bugs in this,
but I'm not aware of any on K8 or recent Intel CPUs. If that didn't
work much more things would be broken too (program/module loading,
JITs)

-Andi
