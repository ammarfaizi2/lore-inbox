Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUIPWQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUIPWQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUIPWPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:15:15 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:29660 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S268037AbUIPWNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:13:18 -0400
From: Duncan Sands <baldrick@free.fr>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Writable module parameters - should be volatile?
Date: Thu, 16 Sep 2004 21:02:57 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200409121357.25915.baldrick@free.fr> <1095098065.25641.38.camel@bach>
In-Reply-To: <1095098065.25641.38.camel@bach>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409162102.57221.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

> > Shouldn't I declare num_rcv_urbs volatile?  Otherwise compiler
> > optimizations could (for example) stick it in a register and miss
> > any changes made by someone writing to it...
> 
> Sure.

except for the compiler warnings...

> If it really matters, you're going to need something stronger 
> than that, eg module_param_call().  For debugging, it's not usually a
> problem.  For more complex parameters, you usually need locks anyway.

Ah ha! - you can supply your own "set" and "get" methods.  Yes, that solves it.

Ciao,

Duncan.

