Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWG1SgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWG1SgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbWG1SgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:36:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:59585 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161224AbWG1SgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:36:17 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 1/2] i386: add CFI macros for stack manipulation
Date: Fri, 28 Jul 2006 20:36:45 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200607281353_MC3-1-C662-536D@compuserve.com>
In-Reply-To: <200607281353_MC3-1-C662-536D@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282036.45608.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 19:50, Chuck Ebbert wrote:
> Add macros to dwarf2.h to simplify pushing and popping stack
> variables.

I feared someone would do that patch. I've thought about it myself.

However it's not a good idea. I've already had complaints that some code in 
x86-64 is too hard to read/debug because it uses too many macros. I think 
it's better  if the core core still uses "real" instructions and keep the 
CFI_* stuff as annotation that most people can just ignore.

With your change that wouldn't be the case and everybody hacking
the code would need to know all of CFI too, which is still quite arcane
stuff.

So while it would make the source shorter and require less typing 
I don't think it's good for readability.

What would be a good thing if someone could write it up would
be a short tutorial for Documentation/* on CFI

-Andi
