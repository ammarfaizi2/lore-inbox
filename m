Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUCRWdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCRWdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:33:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:31881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262566AbUCRWc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:32:58 -0500
Date: Thu, 18 Mar 2004 14:35:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Kenneth Chen" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: add lowpower_idle sysctl
Message-Id: <20040318143504.705dd460.akpm@osdl.org>
In-Reply-To: <200403182159.i2ILxhF12208@unix-os.sc.intel.com>
References: <20040317192821.1fe90f24.akpm@osdl.org>
	<200403182159.i2ILxhF12208@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kenneth Chen" <kenneth.w.chen@intel.com> wrote:
>
> >>>>> Andrew Morton wrote on Wed, March 17, 2004 7:28 PM
> > > "Kenneth Chen" <kenneth.w.chen@intel.com> wrote:
> > >
> > >  Writing to sysctl should be a bool, reading the value can be number of
> > >  module currently disabled low power idle.  I think the original intent
> > >  is to use ref count for enabling/disabling.  (granted, we copied the
> > >  code from other arch).
> >
> > OK, so why not give us:
> >
> > #define IDLE_HALT			0
> > #define IDLE_POLL			1
> > #define IDLE_SUPER_LOW_POWER_HALT	2
> >
> > and so forth (are there any others?).
> >
> > Set some system-wide integer via a sysctl and let the particular
> > architecture decide how best to implement the currently-selected
> > idle mode?
> 
> 
> Sounds good, Thanks for the suggestion. I just coded it up:
> 

Looks fine, thanks.  I'll queue that up pending some code which actually
uses it.  And the obligatory update to Documentation/kernel-parameters.txt ;)
