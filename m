Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTIHVYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTIHVYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:24:24 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:33197 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S263610AbTIHVYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:24:22 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Jamie Lokier'" <jamie@shareable.org>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: THREAD_GROUP and linux thread
Date: Mon, 8 Sep 2003 14:24:14 -0700
Organization: Cisco Systems
Message-ID: <127701c3764f$8e8a2d20$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20030908211234.GA28109@mail.jlokier.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hua Zhong wrote:
> > but I am just wondering if I could just change the kernel to treat
> > CLONE_VM the same way as CLONE_THREAD which is a much 
> simpler change.
> 
> No.  There are a good many programs which use CLONE_VM without
> CLONE_THREAD, and I'm sure they will be surprised to find signals
> suddenly being shared

Thank you, that's exactly what I want to know.

> which is implied by CLONE_THREAD.

The most accurate description is "which is implied by thread_group
list"....

So I guess I'll live with having a separate list.

> > 2. Which version of pthread uses the CLONE_THREAD flag?
> 
> NPTL.
> 
> Enjoy,
> -- Jamie
> 

