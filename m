Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269470AbUJFUti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269470AbUJFUti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269394AbUJFUra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:47:30 -0400
Received: from fmr04.intel.com ([143.183.121.6]:24731 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269470AbUJFUjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:39:02 -0400
Message-Id: <200410062038.i96KcJ608221@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <nickpiggin@yahoo.com.au>, <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Default cache_hot_time value back to 10ms
Date: Wed, 6 Oct 2004 13:38:34 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSr3Irr5GAaCeiRRhG4Prps7qnvLAAAzsqA
In-Reply-To: <20041006123959.4cf20b3b.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, October 06, 2004 12:40 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >  Andrew, can I safely interpret this response as you are OK with having
> >  cache_hot_time set to 10 ms for now?
>
> I have a lot of scheduler changes queued up and I view this change as being
> not very high priority.  If someone sends a patch to update -mm then we can
> run with that, however Ingo's auto-tuning seems a far preferable approach.
>
> >  And you will merge this change for 2.6.9?
>
> I was not planning on doing so, but could be persuaded, I guess.
>
> It's very, very late for this and subtle CPU scheduler regressions tend to
> take a long time (weeks or months) to be identified.


Let me try to persuade ;-).  First, it hard to accept the fact that we are
leaving 11% of performance on the table just due to a poorly chosen parameter.
This much percentage difference on a db workload is a huge deal.  It basically
"unfairly" handicap 2.6 kernel behind competition, even handicap ourselves compare
to 2.4 kernel.  We have established from various workloads that 10 ms works the
best, from db to java workload.  What more data can we provide to swing you in
that direction?

Secondly, let me ask the question again from the first mail thread:  this value
*WAS* 10 ms for a long time, before the domain scheduler.  What's so special
about domain scheduler that all the sudden this parameter get changed to 2.5?
I'd like to see some justification/prior measurement for such change when
domain scheduler kicks in.

- Ken


