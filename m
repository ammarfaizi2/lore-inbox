Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUKIXeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUKIXeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbUKIXeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:34:36 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:55545 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S261768AbUKIX3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:29:54 -0500
Message-ID: <419152D8.9030303@mvista.com>
Date: Tue, 09 Nov 2004 15:29:28 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dhowells@redhat.com, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] Additional kgdb hooks
References: <200411081432.iA8EWf0c023426@warthog.cambridge.redhat.com> <20041108144433.079f0f7c.akpm@osdl.org>
In-Reply-To: <20041108144433.079f0f7c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> dhowells@redhat.com wrote:
> 
>>The attached patch adds a couple of extra hooks by which kgdb or an equivalent
>>gdbstub can catch bad_page() and panic() invocations.
> 
> 
> Tom is valiantly flogging his way through a generic KGDB implementation.  I
> think it would be better to push ahead with that and to not put into
> generic code hooks which are specific to one arch's kgdb implementation.
> 
IMNSHO the trap should be in dump_stack().  That way it catches a bunch of 
things all at once.

Also, panic has a notify option that kgdb should use just like everybody else.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

