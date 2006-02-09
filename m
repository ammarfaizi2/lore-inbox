Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWBIBNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWBIBNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422750AbWBIBNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:13:05 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:10406 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1422751AbWBIBNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:13:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=P+npV9V+NZ52wy39UAmcsRrWBcvbgVGhR7qai56TCx4Y0W/McITLbVcBmHW+JSLCYphJFNpIYhF5DeRMYebVR+A9matt1hRFGSvY6oDvmT7dlOhVSCrSIHaD/UgPynvvKkIexWOwXyms8ipvFL9EairfY2s/xfgVqRkNLjXVWS0=;
Date: Thu, 9 Feb 2006 04:11:26 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
Message-ID: <20060209011126.GB5417@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru> <m1irrpsifp.fsf@ebiederm.dsl.xmission.com> <20060208235348.GC26035@ms2.inr.ac.ru> <m11wyd5pv8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wyd5pv8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> In capability.c it does for_each_thread or something like that.  It is
> very similar to cap_set_pg.  But in a virtual context all != all :)

Do you mean that VPID patch does not include this? Absolutely.
VPIDs are not to limit access, the patch virtualizes pids, rather
than deals with access policy.

Take the whole openvz. Make patch -R < vpid_patch. The result is perfectly
working openvz. Only pids are not virtual, which does not matter. Capisco?


> I think for people doing migration a private pid space in some form is
> necessary, 

Not "private", but "virtual". VPIDs are made only for migration, not for fun.

And word "private" is critical, f.e. for us preserving some form of pid
space is critical. It is very sad, but we cannot do anything with this,
customers will not allow to change status quo.


> My problem with the vpid case and it's translate at the kernel
> boundary is that boundary is huge

Believe me, it is surprizingly small.

Alexey
