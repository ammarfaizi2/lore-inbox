Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWHRRwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWHRRwx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHRRwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:52:53 -0400
Received: from smtp-out.google.com ([216.239.45.12]:55026 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751441AbWHRRww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:52:52 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=crP3WjFxPs2GegMlH6HNOfu/VaxZn/1Jhs48HAUfeyQkePhu8mcTUzSVt5kfFPvVP
	+4kO0OTN6Du5JTda0zxag==
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E5A12E.6020900@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru>
	 <1155751868.22595.65.camel@galaxy.corp.google.com> <44E458C4.9030902@sw.ru>
	 <1155833753.14617.21.camel@galaxy.corp.google.com> <44E5A12E.6020900@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 18 Aug 2006 10:51:10 -0700
Message-Id: <1155923470.23242.18.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 15:14 +0400, Kirill Korotaev wrote:

> >>2. if you think a bit more about it, adding UB parameters doesn't
> >>   require user space changes as well.
> >>3. it is possible to add any kind of interface for UBC. but do you like the idea
> >>   to grep 200(containers)x20(parameters) files for getting current usages?
> > 
> > 
> > How are you doing it currently and how much more efficient it is in
> > comparison to configfs?
> currently it is done with a single file read.
> you can grep it, sum up resources or do what ever you want from bash.
> what is important! you can check whether container hits its limits
> with a single command, while with configs you would have to look through
> 20 files...
> 

I think configfs provides all the required functionality that you
listed. You can define the attributes in a such a away that it prints
all the information that you need in one single read operation (I think
the limit is PAGE_SIZE....which is kind of sad).

I've just started playing with configfs for a container implementation
that I'm trying to get a better idea of details.
 
> IMHO it is convinient to have a text file representing the whole information state
> and system call for applications.
> 

There should be an easy interface for shell to be able to do the needful
as well, for example, set the limits.


-rohit

