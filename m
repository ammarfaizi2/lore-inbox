Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVAIEIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVAIEIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 23:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVAIEIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 23:08:47 -0500
Received: from pat.uio.no ([129.240.130.16]:57293 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262246AbVAIEIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 23:08:40 -0500
Subject: Re: [RFC] 2.4 and stack reduction patches
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105145706.4000.123.camel@dyn318077bld.beaverton.ibm.com>
References: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
	 <20050107141224.GF29176@logos.cnet>
	 <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
	 <1105137646.10979.155.camel@lade.trondhjem.org>
	 <1105145706.4000.123.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Date: Sat, 08 Jan 2005 23:08:15 -0500
Message-Id: <1105243695.17456.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 07.01.2005 Klokka 16:55 (-0800) skreiv Badari Pulavarty:
> On Fri, 2005-01-07 at 14:40, Trond Myklebust wrote:
> 
> > 
> > You're better off using rpc_new_task() in rpc_call_sync(): no kfree()
> > required, and no rpc_init_task() required.
> > 
> 
> Hmm.. I am trying to do this. Just wanted to double check.
> 
> If I don't do kfree(), its gets automatically freed up thro
> rpc_release_task() correct ?

Yes.

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

