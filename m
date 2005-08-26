Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVHZOzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVHZOzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVHZOzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:55:01 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:54034 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S965064AbVHZOzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:55:01 -0400
Date: Fri, 26 Aug 2005 15:50:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
In-Reply-To: <430F20BF.1080703@fujitsu-siemens.com>
Message-ID: <Pine.LNX.4.61L.0508261512520.9561@blysk.ds.pg.gda.pl>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> 
 <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> 
 <20050812133248.GN8974@wotan.suse.de>  <42FCA97E.5010907@fujitsu-siemens.com>
  <42FCB86C.5040509@fujitsu-siemens.com>  <20050812145725.GD922@wotan.suse.de>
  <86802c44050812093774bf4816@mail.gmail.com>  <20050812164244.GC22901@wotan.suse.de>
 <86802c4405081210442b1bb840@mail.gmail.com> <43099FDF.6030504@fujitsu-siemens.com>
 <Pine.LNX.4.61L.0508231204510.2422@blysk.ds.pg.gda.pl> <430F20BF.1080703@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Martin Wilck wrote:

> Unless I am mistaken, the MP spec does not say that _CPUs_ must start from 0.
> We had an IO-APIC at 0. The MP spec says that the IDs must be unique (I am
> told this isn't true any more because an IO APIC and a CPU may have the same
> ID) and _need not_ be consecutive.

 You are unfortunately mistaken -- the spec is explicit about *local* APIC 
IDs having to start at 0.  There are at least two places in the spec that 
refer to that.

> We tried different setups; one had IO APICs at 0,1,2 and CPUs starting at 16.
> I can't see that this is forbidden (the reason is that the IO-APICs have only
> 4-bit APIC ID registers). Anyway we changed it now to have both IO-APICs and
> CPUs start at 0.

 You can always assign 0, 16, 17, etc. to local APICs and then 1, 2, 3, 
etc. for I/O APICs.  Frankly I don't know what the actual justification 
behind the requirement is.  Note that the ID of 0 need not necessarily 
belong to the BSP.

  Maciej
