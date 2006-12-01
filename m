Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759172AbWLAGe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759172AbWLAGe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759225AbWLAGe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:34:58 -0500
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:5545 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1759184AbWLAGe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:34:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=u1q8qaVna6BFKYv9ygOL0pt8eFcD1zpcXj9zsi5wNFynGpQ8dQ9fD/Bk3i+XLISzsS5I+23jgc6KeTxV8/c5gWM4Z2zBhc3BlfMIEHG3U6lmRNdp+PH4BT8mu7fuodnSE4U+OapYp+EuQBYf5wwQjHL/+E+WA6LGTQHCC/Ug334=;
X-YMail-OSG: c2utOnsVM1m0fH7DB0PxLUUx_lI.E2SVqIqzREX8eHMICRxCrVDuL_0ONEvTI0gaByZ6v9fwpTlJyJyxS78pr9J5AQ3LOHSAW8.1NvNRQDLuizRGzJAgRmL25_aJejYW8387CLeuUxdQCpY-
Date: Thu, 30 Nov 2006 22:34:57 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: Infinite retries reading the partition table
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061130214716.6306a586.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <117439.97789.qm@web31803.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 29 Nov 2006 17:22:48 -0800 (PST)
> Luben Tuikov <ltuikov@yahoo.com> wrote:
> 
> > Suppose reading sector 0 always reports an error,
> > sense key HARDWARE ERROR.
> > 
> > What I'm observing is that the request to read sector 0,
> > reading partition information, is retried forever, ad infinitum.
> > 
> > Does anyone have a patch to resolve this? (2.6.19-rc6)
> > 
> 
> Please send a backtrace so we can see where the offending loop occurs.

I posted a patch to linux-scsi which resolves this issue:
http://marc.theaimsgroup.com/?l=linux-scsi&m=116485834119885&w=2

     Luben

