Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUJLW1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUJLW1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUJLW0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:26:44 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:46258 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268039AbUJLWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:25:25 -0400
Message-ID: <416C59CF.1020700@nortelnetworks.com>
Date: Tue, 12 Oct 2004 16:25:19 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
References: <41672D4A.4090200@nortelnetworks.com>	 <1097503078.31290.23.camel@localhost.localdomain>	 <416B6594.5080002@nortelnetworks.com> <1097614971.2639.1.camel@localhost.localdomain>
In-Reply-To: <1097614971.2639.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2004-10-12 at 06:03, Chris Friesen wrote:

>>I must be able to run an app that uses over 90% of system memory, and calls 
>>fork().  I was under the impression this made strict accounting unfeasable?

> Its rather smarter than that, you'll want swap probably. The strict
> accountant is a virtual address accountant not a memory accountant. It
> knows shared r/o segments don't need charging all the time etc

As I said in the first message, I've got no swap.

In any case, moving to -rc4 seems to have cleared up the issue, the patch Chris 
Wright suggested seems to have worked.  Oom killer now wakes up immediately and 
kills one of the memory hogs, and the system continues on.

Chris
