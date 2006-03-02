Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWCBFZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWCBFZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 00:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWCBFZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 00:25:48 -0500
Received: from ozlabs.org ([203.10.76.45]:4578 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751257AbWCBFZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 00:25:47 -0500
Date: Thu, 2 Mar 2006 16:24:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Olof Johansson <olof@lixom.net>
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Fix powerpc bad_page_fault output  (Re: 2.6.16-rc5-mm1)
Message-ID: <20060302052428.GF5552@krispykreme>
References: <20060228042439.43e6ef41.akpm@osdl.org> <4404E328.7070807@mbligh.org> <20060301164531.GA17755@pb15.lixom.net> <17414.15814.146349.883153@cargo.ozlabs.ibm.com> <440646ED.2030108@mbligh.org> <20060302022244.GB17755@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302022244.GB17755@pb15.lixom.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Right. The new printk's were added recently, and I took the KERN_ALERT
> level from the x86 code then without double-checking what die() uses. I
> guess I could move the die() output over instead, or move them both to
> KERN_ERR.

I just noticed x86 can now pass the log level around via
show_trace_log_lvl and show_stack_log_lvl. Something we might want to
add so we can KERN_EMERG the whole oops.

Anton
