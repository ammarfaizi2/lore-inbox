Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWBICvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWBICvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 21:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWBICvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 21:51:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:47052 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422781AbWBICvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 21:51:38 -0500
Date: Wed, 8 Feb 2006 20:51:35 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kirill Korotaev <dev@sw.ru>,
       Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
Message-ID: <20060209025135.GA29197@sergelap.austin.ibm.com>
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru> <m1irrpsifp.fsf@ebiederm.dsl.xmission.com> <20060208235348.GC26035@ms2.inr.ac.ru> <m11wyd5pv8.fsf@ebiederm.dsl.xmission.com> <20060209011126.GB5417@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209011126.GB5417@ms2.inr.ac.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Kuznetsov (kuznet@ms2.inr.ac.ru):
> Hello!
> 
> > In capability.c it does for_each_thread or something like that.  It is
> > very similar to cap_set_pg.  But in a virtual context all != all :)
> 
> Do you mean that VPID patch does not include this? Absolutely.
> VPIDs are not to limit access, the patch virtualizes pids, rather
> than deals with access policy.
> 
> Take the whole openvz. Make patch -R < vpid_patch. The result is perfectly
> working openvz. Only pids are not virtual, which does not matter. Capisco?
> 
> 
> > I think for people doing migration a private pid space in some form is
> > necessary, 
> 
> Not "private", but "virtual". VPIDs are made only for migration, not for fun.
> 
> And word "private" is critical, f.e. for us preserving some form of pid
> space is critical. It is very sad, but we cannot do anything with this,

Hi,

do you mean "preserving some sort of *global* pidspace"?

If not, then I also don't understand what you're saying...

thanks,
-serge
