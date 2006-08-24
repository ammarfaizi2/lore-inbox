Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWHXOLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWHXOLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWHXOLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:11:05 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:64204 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751563AbWHXOLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:11:03 -0400
Date: Thu, 24 Aug 2006 19:33:42 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: ego@in.ibm.com, rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-ID: <20060824140342.GI2395@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20060824103417.GE2395@in.ibm.com> <1156417200.3014.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156417200.3014.54.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 01:00:00PM +0200, Arjan van de Ven wrote:
> On Thu, 2006-08-24 at 16:04 +0530, Gautham R Shenoy wrote:
> > 
> > 
> > This patch renames lock_cpu_hotplug to cpu_hotplug_disable and
> > unlock_cpu_hotplug to cpu_hotplug_enable throughout the kernel.
> 
> Hi,
> 
> to be honest I dislike the new names too. You turned it into a refcount,
> which is good, but the normal linux name for such refcount functions is
> _get and _put.....  and in addition the refcount technically isn't
> hotplug specific, all you want is to keep the kernel data for the
> processor as being "used", so cpu_get() and cpu_put() would sound
> reasonable names to me, or cpu_data_get() cpu_data_put().

Thus, choice of 'cpu_hotplug_disable' and 'cpu_hotplug_enable'
was determined on the basis of its purpose, as in *what* it does 
as opposed to *how* it does it. :)

The name is not much of a concern. I just didn't feel all that 
comfortable with lock_cpu_hotplug because locks are usually 
used to safeguard the data,while here we are trying to
maintain the *state* of the system.

Regards
ego
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
