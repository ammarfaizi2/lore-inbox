Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUGFVuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUGFVuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGFVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:50:07 -0400
Received: from palrel11.hp.com ([156.153.255.246]:6343 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264584AbUGFVuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:50:02 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16619.7814.759319.469038@napali.hpl.hp.com>
Date: Tue, 6 Jul 2004 14:49:58 -0700
To: Peter Martuccelli <peterm@redhat.com>
Cc: akpm@osdl.org, faith@redhat.com, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com
Subject: Re: [PATCH] IA64 audit support
In-Reply-To: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>
References: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is mostly fine with me (it looks identical to me as the last
version I saw from Ray; but my memory may be fuzzy).

There are two minor things I'd like to see changed, though:

 - Use IS_IA32_PROCESS() instead of testing psr.is directly (the macro
   gets defined by system.h and using it ensures that the
   IA-32-specific code will go away if the ia32 subsystem is not
   compiled into the kernel).

 - Remove trailing white-space.

Thanks,

	--david
