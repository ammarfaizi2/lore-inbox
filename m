Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUAIPHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUAIPHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:07:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:40602 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262030AbUAIPHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:07:18 -0500
Subject: Re: eliminating gcc warning...
From: "Yury V. Umanets" <umka@namesys.com>
To: Jesper Juhl <juhl@dif.dk>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0401091539140.12106@jju_lnx.backbone.dif.dk>
References: <1073652555.17813.9.camel@firefly>
	 <Pine.LNX.4.56.0401091539140.12106@jju_lnx.backbone.dif.dk>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1073660886.19099.7.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 09 Jan 2004 18:08:06 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-09 at 17:43, Jesper Juhl wrote:
> On Fri, 9 Jan 2004, Yury V. Umanets wrote:
> 
> > Hello all,
> >
> > I'm trying to eliminate all gcc warnings, which can be obtained by means
> > of using -Wall and -W gcc keys, in linux-2.6.1. I decided, that this
> > should be done step-by-step. And now I have made a patch for scripts
> > directory. See attachment.
> >
> > If something wrong and someone is so kind to tell me about, I will be
> > very thankful.
> >
> 
> I'm doing a similar thing, and there's been quite a lot of discussion
> about patches of this sort.
> 
> You should read the threads with these titles that have been active for
> the last few days :
> 
> "Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested"
> "[PATCH] mm/slab.c remove impossible <0 check - size_t is not signed - patch is against 2.6.1-rc1-mm2"
> "[PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl - arg is unsigned."
> "[PATCH][RFC] variable size and signedness issues in ldt.c - potential problem?"
> "Cleanup patches - comparison is always [true|false] + unsigned/signed compare, and similar issues"
> 
Hello Jesper,

I have read you emails about UFS,ADFS,BEFS,BFS,ReiserFS, etc. earlier
and I want to support your efforts.

> A lot of good comments have been made by various people in those threads
> about what type of patches are wanted and what type of patches are not
> wanted. Also some comments on what kind of warnings not to bother with
> (and why) have been made.
Ok, I will read also other threads. Nevertheless I don't like warnings
at all, doing this my point was to try to find out if some warnings
point to possible bugs. I have found something already in
fs/smbfs/inode.c -- using SET_UID() with 16 bit values.


> May I suggest that we maybe work together on this instead of duplicating
> eachothers effort?
ok, what would be nice.

> If you think that cooperating on this is a good idea, then feel free to
> email me privately and let's talk about how to split the task between us.
ok, I will, thanks.
> 
> 
> -- Jesper Juhl
-- 
umka

