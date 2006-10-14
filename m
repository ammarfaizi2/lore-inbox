Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWJNL4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWJNL4K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWJNL4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:56:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64403 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161124AbWJNL4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:56:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>, "Yinghai Lu" <yinghai.lu@amd.com>
Subject: Re: [1/3] 2.6.19-rc2: known unfixed regressions
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061014111458.GI30596@stusta.de> <20061014112226.GJ30596@stusta.de>
Date: Sat, 14 Oct 2006 05:54:24 -0600
In-Reply-To: <20061014112226.GJ30596@stusta.de> (Adrian Bunk's message of
	"Sat, 14 Oct 2006 13:22:26 +0200")
Message-ID: <m14pu7f6z3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This email lists some known unfixed regressions in 2.6.19-rc2 compared 
> to 2.6.18.
>
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
>
> Due to the huge amount of recipients, please trim the Cc when answering.
>
>

> Subject    : do_IRQ: No irq handler for vector
> References : http://lkml.org/lkml/2006/10/11/13
> Submitter  : Robert Hancock <hancockr@shaw.ca>
> Handled-By : "Eric W. Biederman" <ebiederm@xmission.com>
> Status     : Andrew: a few people are seeing this. Eric is working it.

Please see commit: 994bd4f9f5a065ead4a92435fdd928ac7fd33809
That part should fine in -rc2

YH found a corner case I missed (in my bug fix refactoring) and submitted a patch
earlier today.  But that only shows up when we resubmit an irq which
is almost never.

Eric

