Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVAGRB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVAGRB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVAGRB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:01:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35238 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261517AbVAGRBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:01:18 -0500
Date: Fri, 7 Jan 2005 12:12:24 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 2.4 and stack reduction patches
Message-ID: <20050107141224.GF29176@logos.cnet>
References: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 07:48:06AM -0800, Badari Pulavarty wrote:
> Hi Marcelo,

Hi Badari,

> Few of the product groups are running into stack overflow problems
> on latest 2.4 distribution releases, especially on z-Series.

Lets try to minimize the problems.

> While poking thro the 2.4 code, I realized the 2.6 stack reduction
> work did not get merged into 2.4. 
> 
> Biggest offender seems to be "struct linux_binprm" in do_execve().
> Converting structure on the stack to malloc() (like 2.6 does)
> solved majority of problems. There are other places, but savings
> are smaller. (But after bunch of changes, we were able to reduce
> stack by 1K).

I think the bigger offenders should be fixed. I suppose most of these 
changes are not very intrusive and are acceptable for v2.4.

What are the "other places" that you have fixed? And for how much of 
"1K savings" they account for? 

> I am wondering, if there is any interest in merging stack reduction
> patches into 2.4 mainline ? If so, I will rework the patches on
> latest 2.4 and submit them. 

Please submit them to LKML for peer view - thanks!

