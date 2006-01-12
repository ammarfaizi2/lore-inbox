Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWALHvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWALHvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWALHvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:51:07 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:15260 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932120AbWALHvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:51:06 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: paulmck@us.ibm.com
cc: John Hesterberg <jh@sgi.com>, Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors 
In-reply-to: Your message of "Wed, 11 Jan 2006 22:51:15 -0800."
             <20060112065115.GB23673@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jan 2006 18:50:34 +1100
Message-ID: <19140.1137052234@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" (on Wed, 11 Jan 2006 22:51:15 -0800) wrote:
>On Thu, Jan 12, 2006 at 05:19:01PM +1100, Keith Owens wrote:
>> OK, I have thought about it and ...
>> 
>>   notifier_call_chain_lockfree() must be called with preempt disabled.
>> 
>Fair enough!  A comment, perhaps?  In a former life I would have also
>demanded debug code to verify that preemption/interrupts/whatever were
>actually disabled, given the very subtle nature of any resulting bugs...

Comment - OK.  Debug code is not required, the reference to
smp_processor_id() already does all the debug checks that
notifier_call_chain_lockfree() needs.  CONFIG_PREEMPT_DEBUG is your
friend.

