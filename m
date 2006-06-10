Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWFJHfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWFJHfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 03:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWFJHfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 03:35:17 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:55150 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932429AbWFJHfQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 03:35:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=NhkSOO+R3FN8AWdPQUFswh6OAOi0ZSV/ycHZoK4SDF268ky/bjxdT36Erv59MCNn7ucVxp8vRY9JVbVhkjt+61KSo4PoA2Nja4cEGm1hWBslq0xhDhGYQdN6Eyq3QVDZk56EdMnSp8AnbiqEgE9qSmdAtpsCbw/qoXc9/HreHEs=  ;
Message-ID: <448A762F.7000105@yahoo.com.au>
Date: Sat, 10 Jun 2006 17:35:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: rohitseth@google.com
CC: Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of	physical
 pages backing it
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
In-Reply-To: <1149903235.31417.84.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> Below is a patch that adds number of physical pages that each vma is
> using in a process.  Exporting this information to user space
> using /proc/<pid>/maps interface.
> 
> There is currently /proc/<pid>/smaps that prints the detailed
> information about the usage of physical pages but that is a very
> expensive operation as it traverses all the PTs (for some one who is
> just interested in getting that data for each vma).

Yet more cacheline footprint in the page fault and unmap paths...

What is this used for and why do we want it? Could you do some
smaps-like interface that can work on ranges of memory, and
continue to walk pagetables instead?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
