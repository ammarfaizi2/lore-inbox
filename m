Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263373AbVCEAPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbVCEAPI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVCEANU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:13:20 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:6924 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263078AbVCDXfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:35:13 -0500
Date: Sat, 5 Mar 2005 00:35:02 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050304233502.GA7671@pclin040.win.tue.nl>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304124431.676fd7cf.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:44:31PM -0800, Andrew Morton wrote:

> Here's the list of things which we might choose to put into 2.6.11.2.
...
> nfsd--exportfs-reduce-stack-usage.patch
...

Different people want different things with our 2.6.x.y.
I would hope that criteria include (i) patch is obvious,
and (ii) patch fixes an embarrassing flaw.

I see no reason to include random small improvements.

(Always some of these small improvements will be a mistake,
so, in .y, when something is not really broken, don't fix it.
Maybe people were actually seeing stack overflows here?)

Andries



>> From: NeilBrown <neilb@cse.unsw.edu.au>
>>
>> find_exported_dentry() declares
>>        char nbuf[NAME_MAX+1];
>> in 2 separate places, and gcc allocates space on the stack for both
>> of them.  Having just one of them will suffice, if we can put put
>> with its scope.
>>
>> Reduces function stack usage on x86-32 from 0x230 to 0x130.

