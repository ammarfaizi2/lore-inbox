Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWENDRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWENDRN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 23:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWENDRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 23:17:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932351AbWENDRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 23:17:12 -0400
Date: Sat, 13 May 2006 20:13:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: michael.craig.thompson@gmail.com, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu,
       dhowells@redhat.com
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-Id: <20060513201341.63590cff.akpm@osdl.org>
In-Reply-To: <44669D12.5050306@yahoo.com.au>
References: <20060513033742.GA18598@hellewell.homeip.net>
	<44655ECD.10404@yahoo.com.au>
	<afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com>
	<44669D12.5050306@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Michael Thompson wrote:
>  > On 5/12/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>  >> BTW.  I'm not sure if linux-fsdevel has different conventions; however
>  >> usually you don't break up a patch according to files, but logical
>  >> components or transformations from one "sane" kernel tree to the next.
>  >> And that means things keep compiling and working.
>  > 
>  > 
>  > The files themselves are broken down into logical components, so the
>  > per-file patch approach seems reasonable to me.
> 
>  Half a filesystem is a logical component?
> 
>  At the very least it wires up all the kconfig stuff _first_, so it
>  breaks the tree from about patch 3 until 13.

Doesn't matter.  The rule is stated as "kernel should compile at each
step", but the _real_ rule is "don't break git-bisect".

Nobody is going to include a half-applied filesystem in their .config while
performing git-bisection, so it can go in in any order.
