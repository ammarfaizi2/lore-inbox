Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVKOXPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVKOXPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVKOXPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:15:08 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:45993 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932561AbVKOXPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:15:06 -0500
Message-ID: <437A6BF5.9040901@fr.ibm.com>
Date: Wed, 16 Nov 2005 00:15:01 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>	<20051114153649.75e265e7.pj@sgi.com>	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>	<20051114175140.06c5493a.pj@sgi.com>	<20051115022931.GB6343@sergelap.austin.ibm.com>	<20051114193715.1dd80786.pj@sgi.com>	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>	<20051114223513.3145db39.pj@sgi.com>	<20051115081100.GA2488@IBM-BWN8ZTBWAO1>	<20051115010624.2ca9237d.pj@sgi.com>	<20051115190030.GA16790@sergelap.austin.ibm.com> <20051115141146.5add977c.pj@sgi.com>
In-Reply-To: <20051115141146.5add977c.pj@sgi.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> Oh dear.  I'm drifting away from advocating a pid-range preallocation
> and toward thinking we need a more systematic approach, design and
> architecture.  This isn't just pids.  Simple range based preallocation
> won't help much on some of the other resources that we need to virtualize.

Ah ! you said the word: "virtualize".

> The Zap pods are sounding good to me right now, properly embedded
> in the kernel rather than hacking the syscall table via a module.

hacking the syscall table via a module is evil and does not work. You can't
hack pids in a signal siginfo that way, you won't support NPTL, etc.

> In any case, I am suspecting that starting the job in some sort
> of nice container should be a prerequisite for relocating or
> checkpoint/restarting the job.

Indeed. Did you ever think about using PAGG as a foundation for a
checkpoint/restart container ?

Aggregation and isolation are key requirements for checkpoint/restart. And
then, the next one that comes on the list is private namespace or
virtualization, depends how you call it :)

C.


