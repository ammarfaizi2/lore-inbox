Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWIZTtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWIZTtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWIZTtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:49:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932256AbWIZTtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:49:05 -0400
Date: Tue, 26 Sep 2006 12:48:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: x86/x86-64 merge for 2.6.19
In-Reply-To: <200609261244.43863.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609261241390.3952@g5.osdl.org>
References: <200609261244.43863.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Sep 2006, Andi Kleen wrote:
> 
> Please pull 'for-linus' from
> 	
> 	http://one.firstfloor.org/home/andi/git/linus-2.6

I really don't want do http:// pulls - they are very inefficient, and I 
don't trust the end result because the http protocol isn't really good for 
verifying the end result (same goes for rsync:// to an even bigger 
degree). 

The native git protocol is not just more efficient, it's fundamentally 
designed to be safe (ie everything is purely based on the actual data 
coming down the line - there's no possibility for any hashed object 
corruption, because the receiving side doesn't even care about the SHA1 
names of the data it receives - it will re-compute them).

So please put them on some machine that has either anonymous native git 
access ("git-daemon") or that I can ssh into. I can either just send 
people my ssh key, but I actually prefer avoiding that, and instead just 
have developers use one of the machines that people share ssh access to as 
a meeting point (ie most people use "master.kernel.org" because they 
already had accounts on that machine - if you don't want to actually 
export the tree to the mirrors, just put it in your own home directory and 
make sure I can get read (and execute, for directories) rights to the 
repository.

Thanks,

		Linus
