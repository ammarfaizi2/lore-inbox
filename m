Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264801AbUEYIXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbUEYIXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 04:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbUEYIXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 04:23:42 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:51919 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264801AbUEYIXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 04:23:41 -0400
From: "braam" <braam@clusterfs.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: RE: [PATCH/RFC] Lustre VFS patch
Date: Tue, 25 May 2004 16:21:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRCJC+3UQVfUgs/Sb+H/GITDjHogwABxtyg
In-Reply-To: <20040525064730.GB14792@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <20040525082305.BAEE93101A0@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

I think do answer your question:  
...
> > If we were to return errors, (which, I agree, _seems_ much 
> more sane, 
> > and we _did_ try that for a while!) then there is a good chance, 
> > namely immediately when something is flushed to disk, that 
> the system 
> > will detect the errors and not continue to execute 
> transactions making 
> > consistent testing of our replay mechanisms impossible.

So: we can use the flags, but we cannot return the errors.

> And if this it to make sense for inclusion, io _must_ be 
> ended with -EROFS or similar.
> 
> It seems to me that this probably belongs in your test 
> harness for debugging purposes. At least in its current state 
> it's not acceptable for inclusion.

This is, as I mentioned, only for testing.  It is, clearly, NOT ordinary
system behavior at all since we don't, and won't, return the error. 

Some people find it very convenient to have this available, but if the
opinion is that it is better to let development teams manage their own
testing infrastructure that is acceptable to me.

- Peter -



