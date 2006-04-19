Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWDSSYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWDSSYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDSSYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:24:46 -0400
Received: from fmr18.intel.com ([134.134.136.17]:23266 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751097AbWDSSYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:24:45 -0400
Date: Wed, 19 Apr 2006 11:20:58 -0700
From: Patrick Mochel <mochel@linux.intel.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com,
       muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru
Subject: Re: [patch 1/3] acpi: dock driver
Message-ID: <20060419182058.GB15072@linux.intel.com>
References: <20060412221027.472109000@intel.com> <1144880322.11215.44.camel@whizzy> <20060412222735.38aa0f58.akpm@osdl.org> <1145054985.29319.51.camel@whizzy> <44410360.6090003@sgi.com> <1145383396.10783.32.camel@whizzy> <20060418225427.GE4556@linux.intel.com> <1145466537.21185.24.camel@whizzy> <20060419172816.GA14304@linux.intel.com> <1145471322.21185.55.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145471322.21185.55.camel@whizzy>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 11:28:42AM -0700, Kristen Accardi wrote:

> Well, I will certainly change the dock code, but pulling this stuff out
> of the hotplug drivers will take longer since it would require changing
> the offending acpi interfaces.  

If you ever decide to do this, you can make it much easier on yourself 
by doing a "bait and switch": create a new function that wraps the
currently exported one and exposes a clean, sane interface. Then, 
convert the users to call this new function. When they're all converted,
un-export the old one, then take it out back and do away with it. This
allows a step-by-step conversion without having to coordinate a big
"flag day" cutover.. 


	Pat
