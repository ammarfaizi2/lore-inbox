Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbTCRFfR>; Tue, 18 Mar 2003 00:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbTCRFfR>; Tue, 18 Mar 2003 00:35:17 -0500
Received: from mpls-qmqp-04.inet.qwest.net ([63.231.195.115]:48652 "HELO
	mpls-qmqp-04.inet.qwest.net") by vger.kernel.org with SMTP
	id <S262177AbTCRFfR>; Tue, 18 Mar 2003 00:35:17 -0500
Date: Mon, 17 Mar 2003 23:43:24 -0800
Message-ID: <002801c2ed22$0f7fcd20$a3ba0243@oemcomputer>
From: "Paul Albrecht" <palbrecht@uswest.net>
To: "Rik van Riel" <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303171001030.2571-100000@chimarrao.boston.redhat.com>
Subject: Re: 2.4 vm, program load, page faulting, ...
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, March 17, 2003 Rik van Riel wrote:

>
> The mmap() syscall only sets up the VMA info, it doesn't fill in the page
tables. That only happens when the process page faults.
>
> Note that filling in a bunch of page table entries mapping already present
pagecache pages at exec() time might be a good idea.  It's just that nobody
has gotten around to that yet...
>

What doesn't make sense to me is that a program's working set isn't loaded
before it starts execution.  Can the working set be approximated using the
address_space object?  Then the kernel would know what pages should be
allocated when the text and data segments are memory mapped in binary load.

