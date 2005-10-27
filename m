Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVJ0DZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVJ0DZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 23:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbVJ0DZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 23:25:36 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:42939 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751545AbVJ0DZg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 23:25:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WWWHCKAr4460L2Zp/s8BMej2PFNPP6t1xPRbqZMU7LKuvAwBDfXyQPFjJOyRw+lI19HUkydb1TdayLFIhilo7wbz6dpbI3HvmonD0y4UGs/NKWdzqPTznKQyUNRuhfJjIaDVsA9uh9RW5QtohAMTb0eeIZ4kEgJBkiN8iWT6hXs=
Message-ID: <aec7e5c30510262025q4cd09758g2a6319e21889c3f5@mail.gmail.com>
Date: Thu, 27 Oct 2005 12:25:35 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] CPUSETS: remove SMP dependency
Cc: Andrew Morton <akpm@osdl.org>, magnus@valinux.co.jp,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051026102509.0b32006d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026075345.21014.53533.sendpatchset@cherry.local>
	 <20051026010922.5a8f70fe.akpm@osdl.org>
	 <20051026102509.0b32006d.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Paul Jackson <pj@sgi.com> wrote:
> Andrew, responding to Magnus:
> > > Remove the SMP dependency from CPUSETS.
> >
> > Why?
>
> As described in the posting that Magnus linked to, it seemed to me
> like the cleaner approach - if there is no need to link two CONFIG
> options, then don't.
>
> Perhaps someone wants to build a uni-processor (UP) kernel for other
> reasons, but still have it support running some stuff that depends
> on cpusets being present.

Exactly, and the current Kconfig assumes that all NUMA systems are
configured with SMP. But that does not have to be the case, especially
with NUMA_EMU.

Depending on SMP only is wrong IMO because CPUSETS manages both sets
of cpus (SMP) and sets of mems (NUMA).

So CPUSETS should either depend on SMP || NUMA or nothing.

/ magnus
