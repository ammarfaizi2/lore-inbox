Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUGIXvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUGIXvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGIXvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:51:50 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26229 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264903AbUGIXvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:51:35 -0400
Date: Fri, 9 Jul 2004 16:49:19 -0700
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, herbert@gondor.apana.org.au, chrisw@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-Id: <20040709164919.6b6a077d.pj@sgi.com>
In-Reply-To: <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> 
> Does this mean constructs like:
> ``if (pointer)'' and ``if (!pointer)'' are also outlawed.
> 
> And do we then need to initialize static pointers to NULL instead
> of letting them be implicitly 0.
> 
> Is doing memset(&(struct with_embeded_pointers), 0, sizeof(struct))
> also wrong?

I suspect not.  Up to Linus.  This is all about writing code that
doesn't bite.

Since mostly it's us humans doing the writing, this is more a human
engineering problem than a pure mathematics problem such as Dijkstra
or Wirth were closer to addressing.

Let someone with demonstrated good taste dictate the style choices
that lead to short, sweat, but seldom screwy code.

It's all arbitrary as hell.  The proof is in the pudding.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
