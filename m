Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965923AbWKTPvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965923AbWKTPvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965939AbWKTPvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:51:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965923AbWKTPvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:51:09 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4561CB33.2060502@s5r6.in-berlin.de> 
References: <4561CB33.2060502@s5r6.in-berlin.de>  <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <20061120142716.12685.47219.stgit@warthog.cambridge.redhat.com> 
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] WorkStruct: Separate delayable and non-delayable events. 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 20 Nov 2006 15:43:01 +0000
Message-ID: <14240.1164037381@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> A consequent (if somewhat silly) name for queue_delayed_work would be
> queue_delayed_dwork, since it requires a struct dwork_struct.

Yeah...  Sometimes I wish C has type-based function overloading like C++ does.

> Are there many or frequent usages of "undelayed delayable work" like
> above, where runtime decides if a delay is necessary? If not,
> queue_dwork could be removed from the API and queue_(delayed_|d)work be
> called with delay=0.

There are a few, but not many.  Your suggestion is a good one, I think.
queue_delayed_work() can just devolve to queue_work() if delay == 0.

David
