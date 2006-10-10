Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWJJUDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWJJUDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWJJUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:03:52 -0400
Received: from gw.goop.org ([64.81.55.164]:59574 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030240AbWJJUDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:03:51 -0400
Message-ID: <452BFCAC.5040802@goop.org>
Date: Tue, 10 Oct 2006 13:03:56 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: tim.c.chen@linux.intel.com, Andrew Morton <akpm@osdl.org>,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <1159916644.8035.35.camel@localhost.localdomain>	 <4522FB04.1080001@goop.org>	 <1159919263.8035.65.camel@localhost.localdomain>	 <45233B1E.3010100@goop.org>	 <1159968095.8035.76.camel@localhost.localdomain>	 <20061004093025.ab235eaa.akpm@osdl.org>	 <1159978929.8035.109.camel@localhost.localdomain>	 <20061004103408.1a38b8ad.akpm@osdl.org>	 <1160442541.4548.15.camel@localhost.localdomain> <1160485474.22525.6.camel@localhost.localdomain>
In-Reply-To: <1160485474.22525.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> Holy crap!  I wonder where else in the kernel gcc is doing this. (of
> course I'm using gcc4 so I don't know).  Is there another gcc attribute
> to actually tell gcc that a variable is really mostly read only (besides
> placing it in a mostly read only elf section)?
>   

That would be nice, but I don't know of one (apart from "volatile", 
which has its own downsides).  Once could imagine an annotation which 
makes gcc consider writes to the variable relatively expensive, so that 
it avoids generating unnecessary/excessive writes.

    J
