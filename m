Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTKUUKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 15:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTKUUKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 15:10:23 -0500
Received: from 217-124-33-199.dialup.nuria.telefonica-data.net ([217.124.33.199]:3968
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S264422AbTKUUKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 15:10:22 -0500
Date: Fri, 21 Nov 2003 21:10:19 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, Voicu Liviu <pacman@mscc.huji.ac.il>,
       kerin@recruit2recruit.net
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031121201019.GA5848@localhost>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Voicu Liviu <pacman@mscc.huji.ac.il>,
	kerin@recruit2recruit.net
References: <20031120225354.GB5094@localhost> <20031120225629.GN22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120225629.GN22764@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 November 2003, at 14:56:29 -0800,
William Lee Irwin III wrote:

> @@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
>  	pte_t entry;
>  	struct pte_chain *pte_chain;
>  	int sequence = 0;
> -	int ret;
> +	int ret = VM_FAULT_MINOR;
>  
I applied it manually to 2.6.0-test9-mm4 (because there is some offset
that prevents the patch to apply cleanly to it).

Compiled the kernel with the exact same configuration used in previous
tests, as well as modules. Booted with this new kernel
(2.6.0-test9-mm4-fix) and reconfigured (vmware-config.pl) VMware.

Otherwise, everything is as it was yesterday. Booted the program,
started the same guest operating system as ever, and now the BUG is gone
and everything works OK.

Great work, greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test9-mm4-fix)
