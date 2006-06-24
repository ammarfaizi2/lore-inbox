Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWFXAjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWFXAjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWFXAjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:39:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6561 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932634AbWFXAjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:39:04 -0400
Date: Fri, 23 Jun 2006 20:38:56 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, discuss@x86-64.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [20/82] i386: Panic the system when a NUMA kernel doesn't run on IBM NUMA
Message-ID: <20060624003856.GE19461@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	torvalds@osdl.org, discuss@x86-64.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <449C8510.mailCWD11E44E@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449C8510.mailCWD11E44E@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 02:19:28AM +0200, Andi Kleen wrote:


 > +	extern int use_cyclone;
 > +	if (use_cyclone == 0) {
 > +		/* Make sure user sees something */
 > +		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
 > +		early_printk(s);
 > +		panic(s);
 > +	}

non-IBM Machines do still boot with that enabled though don't they?
Turning previously working configurations into panic()'s seems a bit odd,
even with a warning.

		Dave

-- 
http://www.codemonkey.org.uk
