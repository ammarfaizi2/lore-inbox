Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUJBUpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUJBUpf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUJBUpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 16:45:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:62114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267551AbUJBUpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 16:45:33 -0400
Date: Sat, 2 Oct 2004 13:40:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: mef@CS.Princeton.EDU, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, pj@sgi.com, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041002134059.65b45e29.akpm@osdl.org>
In-Reply-To: <415ED4A4.1090001@watson.ibm.com>
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
	<415ED4A4.1090001@watson.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> wrote:
>
> Marc, cpusets lead to physical isolation.

Despite what Paul says, his customers *do not* "require" physical isolation
[*].  That's like an accountant requiring that his spreadsheet be written
in Pascal.  He needs slapping.

Isolation is merely the means by which cpusets implements some higher-level
customer requirement.

I want to see a clearer description of what that higher-level requirement is.

Then I'd like to see some thought put into whether CKRM (with probably a new
controller) can provide a good-enough implementation of that requirement.

Coming at this from the other direction: CKRM is being positioned as a
general purpose resource management framework, yes?  Isolation is a simple
form of resource management.  If the CKRM framework simply cannot provide
this form of isolation then it just failed its first test, did it not?

[*] Except for the case where there is graphics (or other) hardware close
to a particular node.  In that case it is obvious that CPU-group pinning is
the only way in which to satisfy the top-level requirement of "make access
to the graphics hardware be efficient".
