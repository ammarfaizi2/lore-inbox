Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUKIPoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUKIPoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUKIPoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:44:17 -0500
Received: from jade.aracnet.com ([216.99.193.136]:10671 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261557AbUKIPoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:44:07 -0500
Date: Tue, 09 Nov 2004 07:43:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jake Moilanen <moilanen@austin.ibm.com>,
       Leo Przybylski <leo@leosandbox.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Blast and data miscompare
Message-ID: <277580000.1100015035@[10.10.2.4]>
In-Reply-To: <20041109093400.34b49953@localhost>
References: <41847C52.8030702@leosandbox.org> <20041109093400.34b49953@localhost>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Jake Moilanen <moilanen@austin.ibm.com> wrote (on Tuesday, November 09, 2004 09:34:00 -0600):

>> I have tried searching on this issue, but found nothing. I heard from a 
>> kernel developer at work that a memory error was discovered recently in 
>> the linux 2.6 kernel that causes data miscompare errors in the generic 
>> scsi driver when executing blast tests.
>> 
>> Does anyone know more about this???
> 
> Not sure if it's the same problem.  But we were seeing a miscompare on
> 2.4 due to a incorrect COW happening, followed by a hardware hash hole
> w/ PPC64.
> 
> To fix it we had to make sure that the PTE was cleared and the TLB's
> flushed before the new PTE was established.
> 
> Martin, was this fixed on 2.6?

Yup, was already fixed in 2.6, and is PPC64 only. Most of those errors
tend to be caused by IO problems ...

M.

