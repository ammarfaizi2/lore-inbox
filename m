Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWGFS3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWGFS3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWGFS3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:29:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750705AbWGFS3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:29:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060706103622.ebf00e68.akpm@osdl.org> 
References: <20060706103622.ebf00e68.akpm@osdl.org>  <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124721.7098.50514.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] FRV: Fix FRV arch compile errors [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 06 Jul 2006 19:29:25 +0100
Message-ID: <25951.1152210565@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> ocrap, I didn't read this bit.  Really?

Really.  See the reply I sent a short while ago for more details.

> We skip the section tag on the declaration all over the place and keeping
> them in sync is going to be quite unreliable due to lack of compiler
> checking.

Yeah.  I've added quite a few previously to get FRV to link.

> So this wants to be __meminitdata.  Problem.  How does it manifest on FRV? 
> A linker error or a mysterious crash?

A linker error: the offset from the GP-register position to the variable
exceeds what'll fit in an address offset field.

David
