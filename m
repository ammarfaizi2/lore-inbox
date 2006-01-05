Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752136AbWAEKxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbWAEKxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWAEKxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:53:22 -0500
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:27327 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S1752136AbWAEKxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:53:22 -0500
Date: Thu, 5 Jan 2006 02:51:30 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: ptrace denies access to EFLAGS_RF
Message-ID: <20060105105130.GC3712@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to the user HW debug registers on i386
and I am running into a problem with ptrace() not allowing access
to EFLAGS_RF for POKEUSER (see FLAG_MASK).

I am not sure I understand the motivation for denying access
to this flag which can be used to resume after a code
breakpoint has been reached. It avoids the need to remove the
breakpoint, single step, and reinstall. The equivalent
functionality exists on IA-64 and is allowed by ptrace().

Why is EFLAGS_RF not accessible to users on i386?

Thanks.

-- 
-Stephane
