Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWHaHP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWHaHP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWHaHP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:15:58 -0400
Received: from ns.suse.de ([195.135.220.2]:4746 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750825AbWHaHP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:15:57 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/8] Fix places where using %gs changes the usermode ABI.
Date: Thu, 31 Aug 2006 09:11:20 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060830235201.106319215@goop.org> <20060831000514.954578791@goop.org>
In-Reply-To: <20060831000514.954578791@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608310911.20206.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 01:52, Jeremy Fitzhardinge wrote:
> ===================================================================
> --- a/arch/i386/kernel/ptrace.c
> +++ b/arch/i386/kernel/ptrace.c
> @@ -94,13 +94,9 @@ static int putreg(struct task_struct *ch


[...] So did you check that ESP, EIP, EFLAGS now come out correctly again? 
(e.g. do gdb and strace still work?)

-Andi
