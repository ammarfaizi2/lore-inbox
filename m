Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWAIFx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWAIFx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWAIFxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:53:55 -0500
Received: from fmr14.intel.com ([192.55.52.68]:64896 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750749AbWAIFxy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:53:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 00:53:12 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUiMwPhgoBlx6KSjq/Dh8hEV8oYAAV/RaA
From: "Brown, Len" <len.brown@intel.com>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, <torvalds@osdl.org>,
       <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>, <git@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2006 05:53:15.0685 (UTC) FILETIME=[FBD41D50:01C614E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On 1/9/06, Brown, Len <len.brown@intel.com> wrote:
>> Perhaps the tools should try to support what "a lot of people"
>> expect, rather than making "a lot of people" do extra work
>> because of the tools?
>
>I think it does. All the tricky stuff that David and Junio have been
>discussing is actually done very transparently by
>
>    git-rebase <upstream>
>
>Now, git-rebase uses git-format-patch <options> | git-am <options> so
>it sometimes has problems merging. In that case, you can choose to
>either resolve the problem (see the doco for how to signal to git-am
>that you've resolved a conflict) or to cancel the rebase. If you
>choose to cancel the rebase, do
>
>   cp .git/refs/heads/{<headname>,<headnamebadrebase>}
>   cat .git/HEAD_ORIG > .git/refs/heads/<headname>
>   git-reset --hard
>   rm -fr .dotest
>
>and you'll be back to where you started. Perhaps this could be rolled
>into something like git-rebase --cancel to make it easier, but that's
>about it. The toolchain definitely supports it.

This is completely insane.
Do you have any idea what "sometimes has problems merging" means
in practice?  It means the tools are really nifty in the trivial
case but worse than worthless when you need them the most.

-Len
