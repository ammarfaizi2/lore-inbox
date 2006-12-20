Return-Path: <linux-kernel-owner+w=401wt.eu-S964923AbWLTGsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWLTGsl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 01:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWLTGsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 01:48:41 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:55664 "EHLO
	liaag2aa.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964923AbWLTGsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 01:48:40 -0500
Date: Wed, 20 Dec 2006 01:42:48 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
To: Andrew Morton <akpm@osdl.org>
Cc: Zhang Yanmin <yanmin.zhang@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       bugme-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <200612200145_MC3-1-D5AF-61E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061219172900.37312b38.akpm@osdl.org>

On Tue, 19 Dec 2006 17:29:00 -0800, Andrew Morton wrote:

> Quoting the bug report:

> general protection fault: 013b [1] PREEMPT 

That '013b' is critical information.

Bit 0: 1: exception source is external to the processor
Bit 1: 1: there is a problem with an interrupt descriptor in the IDT
Bit 2: n/a
Bits 15-3: index of the problem descriptor

So an external interrupt occurred, the system tried to use interrupt
descriptor #39 decimal (irq 7), but the descriptor was invalid.
-- 
MBTI: IXTP

