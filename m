Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUFALi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUFALi6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUFALi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:38:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:5264 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265000AbUFALh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:37:59 -0400
Subject: Re: I would like to see ReiserFS V3 enter a feature freeze real
	soon.
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Vladimir Saveliev <vs@namesys.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Alexander Zarochentcev <zam@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>
In-Reply-To: <40BB61C0.5020902@namesys.com>
References: <20040528122854.GA23491@clipper.ens.fr>
	 <1085748363.22636.3102.camel@watt.suse.com>
	 <1085750828.1914.385.camel@tribesman.namesys.com>
	 <1085751695.22636.3163.camel@watt.suse.com>  <40BB61C0.5020902@namesys.com>
Content-Type: text/plain
Message-Id: <1086089827.22636.3391.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Jun 2004 07:37:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-31 at 12:48, Hans Reiser wrote:
> While I like and appreciate the data journaling stuff, and I think it 
> should go in, real soon now I think we should avoid adding new features 
> to V3.  Let the mission critical server folks have a reiserfs version 
> that only gets bug fixes added to it, and let V4 be for those who want 
> excitement.
> 
> Are there any things which Chris and Jeff think should go in besides 
> data journaling/ordering and bitmap algorithm changes?
> 

We've got io error fault tolerance that needs to go in after the barrier
code has stabilized.  I can't promise that I'll never making another
change in there, but my goal is to keep them to a minimum.

> Also, I would like to see some serious benchmarks of the bitmap 
> algorithm changes before they go in.  They seem nice in theory, and some 
> users liked them for their uses, but that does not make a serious 
> scientific study.  Such a study has a high chance of making them even 
> better.;-)
> 

Some benchmarks have been posted on reiserfs-list, but I'd love to
coordinate with you on getting some mongo numbers.  I can spout off a
long list of places where the code does better then the original v3
allocator, but that's because those were the ones I was trying to fix
;-)

> zam, I view you as the block allocator maintainer, please review that 
> bitmap code from Chris.
> 
> Chris and Jeff, can you propose a benchmarking plan for the bitmap code?

A good start would be to just rebenchmark against v4.

-chris


