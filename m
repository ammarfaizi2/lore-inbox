Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWH0VjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWH0VjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWH0VjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:39:14 -0400
Received: from ns1.suse.de ([195.135.220.2]:17282 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932263AbWH0VjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:39:13 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Sun, 27 Aug 2006 23:39:08 +0200
User-Agent: KMail/1.9.3
Cc: Dong Feng <middle.fengdong@gmail.com>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <200608272252.48946.ak@suse.de> <Pine.LNX.4.64.0608271404260.22510@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608271404260.22510@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272339.08092.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 23:05, Christoph Lameter wrote:
> On Sun, 27 Aug 2006, Andi Kleen wrote:
> 
> > rwsems don't -- there are two flavours: a generic spinlock'ed one and a 
> > complicated atomic based one that only works on some architectures. 
> > As far as I know nobody has demonstrated a clear performance increase
> > from the first so it might be possible to switch all to the generic
> > implementation.
> 
> Yup that would be the major issue.I'd be interested to see some tests in 
> that area.

x86-64 always uses the spinlocked version (vs i386 using the atomic one)
and I haven't heard of anybody complaining.

-Andi
