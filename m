Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWFOFpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWFOFpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWFOFpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:45:08 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:26666 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932440AbWFOFpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:45:07 -0400
X-IronPort-AV: i="4.06,134,1149490800"; 
   d="scan'208"; a="1825977090:sNHT31549832"
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Voluspa <lista1@comhem.se>, linux-kernel@vger.kernel.org,
       akpm <akpm@osdl.org>, len.brown@intel.com
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
X-Message-Flag: Warning: May contain useful information
References: <20060615010850.3d375fa9.lista1@comhem.se>
	<4490B48E.5060304@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 14 Jun 2006 22:45:03 -0700
In-Reply-To: <4490B48E.5060304@oracle.com> (Randy Dunlap's message of "Wed, 14 Jun 2006 18:14:54 -0700")
Message-ID: <adaslm7ynts.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Jun 2006 05:45:05.0482 (UTC) FILETIME=[DA7FD2A0:01C6903E]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > [UBUNTU:acpi/ec] Use semaphore instead of spinlock to get rid of missed
 > interrupts on ACPI EC (embedded controller)

 > -		spinlock_t lock;
 > +		struct semaphore sem;

 > +	init_MUTEX(&ec->poll.sem);

I think nowadays this should be a struct mutex...
