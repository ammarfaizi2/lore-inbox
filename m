Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVGFFtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVGFFtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVGFFrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:47:00 -0400
Received: from web34413.mail.mud.yahoo.com ([66.163.178.162]:17578 "HELO
	web34413.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261494AbVGFEDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:03:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GvlGY/RwfPZfhjUKQV8l6A6DuHm8tpoQFnciOSsOpVwgh9BYSmsvWHP+sU6RZNaj3ngx7dyym0VkM7z2viq23eu1QFq4uL9QQKDIKlhf8A1qkTPmo6PZLA7hQ2bGtBIqePbW9E41+QoMEc1wC/XEi9sGz+R7yLCt84LGSzVx3D4=  ;
Message-ID: <20050706040319.35013.qmail@web34413.mail.mud.yahoo.com>
Date: Tue, 5 Jul 2005 21:03:19 -0700 (PDT)
From: <jscottkasten@yahoo.com>
Subject: Re: Sending ethernet frames one after another
To: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050705155249.GA11451@kestrel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Karel Kulhavy <clock@twibright.com> wrote:

> Hello
> 
> I have written a software to test connected optical
> datalink in loopback
> mode which works by sending a burst of e. g. 1024
> raw Ethernet frames
> directly to that interface, then waiting a little
> bit, and counting from
> ifconfig how many were received.
> 
> Some people report a problem that on their eepro100
> in IBM Thinkpad, the
> program (probably sendto) is returning error "No
> buffer space available".
> 
> Why doesn't the sendto block instead? Does it mean
> that I cannot use

Are you sure that it is the program getting this
error?  Have you traced this to a bad return from the
sendto function?

I have a couple thoughs.  One issue with the memory is
that going in and out of the driver, the network
buffers are DMA quality memory (meaning hardware
accessable address space, and contiguous physically,
rather than virtually).  When things get churned up it
can be difficult to get memory that fits those
criteria.

-S-
