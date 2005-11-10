Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVKJOCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVKJOCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVKJOBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:01:54 -0500
Received: from mx1.suse.de ([195.135.220.2]:44493 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750897AbVKJOBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:01:18 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 18/39] NLKD/x86-64 - INT1/INT3 handling changes
Date: Thu, 10 Nov 2005 14:21:48 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <437210D1.76F0.0078.0@novell.com> <4372120B.76F0.0078.0@novell.com>
In-Reply-To: <4372120B.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101421.48950.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 15:13, Jan Beulich wrote:
> This
> - switches the INT3 handler to run on an IST stack (to cope with
>   breakpoints set by a kernel debugger on places where the kernel's
>   %gs base hasn't been set up, yet); the IST stack used is shared with
>   the INT1 handler's
> - allows nesting of INT1/INT3 handlers so that one can, with a kernel
>   debugger, debug (at least) the user-mode portions of the INT1/INT3
>   handling; the nesting isn't actively enabled here since a kernel-
>   debugger-free kernel doesn't need it

Looks reasonable except for the CONFIG_NLKD hunk, which doesn't
seem to be related. I think I'll apply it without that.

-Andi
