Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUHTUlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUHTUlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUHTUit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:38:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64938 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268737AbUHTUgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:36:07 -0400
Date: Fri, 20 Aug 2004 16:35:47 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <20040820201914.GA1244@us.ibm.com>
Message-ID: <Xine.LNX.4.44.0408201633390.2238-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +		hvalue = atomic_inc_return(&avc_cache.lru_hint) % AVC_CACHE_SLOTS;

atomic_inc_return() is not implemented on ia32 or x86-64.  Is there a 
workaround, or do we need to implement it?  (Andi Kleen suggested using 
the xadd instruction and altinstructions for i386).


- James
-- 
James Morris
<jmorris@redhat.com>


