Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbVIMPP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVIMPP7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVIMPP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:15:59 -0400
Received: from xenotime.net ([66.160.160.81]:55992 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932667AbVIMPP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:15:59 -0400
Date: Tue, 13 Sep 2005 08:15:57 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: iSteve <isteve@rulez.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: query_modules syscall gone? Any replacement?
In-Reply-To: <4326DE0E.2060306@rulez.cz>
Message-ID: <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net>
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz>
 <4326DE0E.2060306@rulez.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, iSteve wrote:

> Okay, so, I have so far gathered:
>
>   - the whole module interface change between 2.4 and 2.6 was because
> some security concerns, most of the stuff (loading module etc.) moved
> towards kernel

I thought it was due to raciness or locking concerns, but
I'm not sure about that.

>   - query_module is gone, there is no syscall similar in function but
> with different name

Right.

>   - losing of query_module also prevents binary-only modules
> (guesswork@work)

Nope, they are not prevented.  However, there is a Tainted flag
that is set when one is loaded (and that flag is never cleared).

>   - /proc/modules and /sys/module interface doesn't by far supply what
> query_module could do

Can you state succinctly exactly what you are trying to do?

> My questions are:
> a) Are my observations correct? Where did I go wrong?
> b) Is there any planned replacement of query_module, or extendind sysfs
> or procfs module interface?

Haven't heard of one.

> c) Wouldn't revamping query_module also allow binary-only modules,

they are still possible.

> therefore easier decisions for vendors, whether to support Linux?
>
> Thanks in advance and sorry for these probably quite silly questions.
>
>   - iSteve

-- 
~Randy
