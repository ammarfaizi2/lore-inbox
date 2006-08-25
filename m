Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWHYJuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWHYJuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWHYJuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:50:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6530 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751392AbWHYJux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:50:53 -0400
Date: Fri, 25 Aug 2006 05:50:08 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, rusty@rustcorp.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060825095008.GC22293@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, ego@in.ibm.com,
	rusty@rustcorp.com.au, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
	vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
References: <20060824102618.GA2395@in.ibm.com> <20060824091704.cae2933c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824091704.cae2933c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 09:17:04AM -0700, Andrew Morton wrote:
 > We already have sufficient locking primitives to get this right.  Let's fix
 > cpufreq locking rather than introduce complex new primitives which we hope
 > will work in the presence of the existing mess.
 > 
 > Step 1: remove all mention of lock_cpu_hotplug() from cpufreq.
 > Step 2: work out what data needs to be locked, and how.
 > Step 3: implement.

this is what I planned to do weeks ago when this mess first blew up.
I even went as far as sending Linus a patch for (1).
He seemed really gung-ho about trying to fix up the current mess though,
and with each incarnation since, I've been convinced we're making
the problem worse rather than really improving anything.

		Dave

-- 
http://www.codemonkey.org.uk
