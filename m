Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTDLTus (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTDLTus (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:50:48 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28689
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263386AbTDLTur 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 15:50:47 -0400
Subject: Re: Re: Processor sets (pset) for linux kernel 2.5/2.6?
From: Robert Love <rml@tech9.net>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org, thockin@isunix.it.ilstu.edu
In-Reply-To: <1050177383.3e986f67b7f68@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1050177383.3e986f67b7f68@netmail.pipex.net>
Content-Type: text/plain
Organization: 
Message-Id: <1050177751.2291.468.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 12 Apr 2003 16:02:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 15:56, Shaheed R. Haque wrote:

> Hmmm, AFAICS, sched_getaffinity() and sched_setaffinity() 
> allow the calling process to be bound to the nominated CPU(s), but that is not 
> the same as giving them exclusive access, is it? In other words, other 
> processes which have no particualr affinity needs can presumably still be 
> scheduled to run on the same processor. 
> 
> I am looking for something more akin to the patch I referred to...or did I miss 
> something in the effect of set_cpus_allowed()?

We strive for simple interfaces here in Linux :)

If you want to give them exclusive access, you need to bind all the
other processes to the other processors.  One easy way to do this is to
have init bind itself elsewhere on boot.

	Robert Love

