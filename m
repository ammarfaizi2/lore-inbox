Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUDIUEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 16:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUDIUEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 16:04:36 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:3857 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261611AbUDIUEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 16:04:30 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Date: Fri, 9 Apr 2004 23:04:18 +0300
User-Agent: KMail/1.5.4
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
References: <20040401122802.23521599.pj@sgi.com> <200404091054.24618.vda@port.imtp.ilyichevsk.odessa.ua> <20040409105349.6b40fe02.pj@sgi.com>
In-Reply-To: <20040409105349.6b40fe02.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404092304.18621.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 April 2004 20:53, Paul Jackson wrote:
> > > It may well make sense for the O(1) scheduler to be inlining this.
> >
> > Why?
>
> I was thinking that perhaps this call was in a certain critical
> performance path of the O(1) scheduler.

Even if it is used in some time critical place, adding call overhead
~350 byte function will barely be noticeable on speed, but
*will* be noticeable on size.

> Turned out it wasn't - see further Nick Piggin's followups to this
> same thread.
>
> My latest bitmap/cpumask patch moves this out of line, for ia64.
> The other arch's that use this large find_next_bit() code might
> want to move it out too.

We have far too many large inlines to kill them one by one.
Nedd to automate that.
--
vda

