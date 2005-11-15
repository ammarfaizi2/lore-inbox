Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVKOVDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVKOVDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKOVDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:03:13 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:53958 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750761AbVKOVDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:03:12 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>,
       Andi Kleen <ak@suse.de>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [Patch 2.6.15-rc1] Clean up the die notifier registration routines 
In-reply-to: Your message of "Tue, 15 Nov 2005 10:09:32 CDT."
             <Pine.LNX.4.44L0.0511151007560.4851-100000@iolanthe.rowland.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 Nov 2005 08:02:57 +1100
Message-ID: <19732.1132088577@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005 10:09:32 -0500 (EST), 
Alan Stern <stern@rowland.harvard.edu> wrote:
>On Tue, 15 Nov 2005, Keith Owens wrote:
>
>> Remove the extraneous die_notifier_lock, notifier_chain_register()
>> and notifier_chain_unregister already take a lock.  Also there is some
>> work being done to make the generic notify code race safe and the
>> die_notifier_lock would get in that way of that rework.  See
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=113175279131346&w=2
>
>Keith, can you delay this patch until the general notifier fixups have
>been merged?  Most of what you did duplicates changes that we are making
>and some of it will clash.

No problem.  SInce you are doing notifier cleanups as well, feel free
to fold my patch into yours.

