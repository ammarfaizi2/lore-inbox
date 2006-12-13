Return-Path: <linux-kernel-owner+w=401wt.eu-S965016AbWLMQU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWLMQU5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWLMQU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:20:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:22091 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965016AbWLMQU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:20:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="173988144:sNHT31290784"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Miquel van Smoorenburg'" <miquels@cistron.nl>,
       <linux-kernel@vger.kernel.org>
Subject: RE: cfq performance gap
Date: Wed, 13 Dec 2006 08:20:52 -0800
Message-ID: <000001c71ed2$a90019b0$2e81030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccenoQNNLFdbxshSYaNFxCdvQHIVAAM8jcA
In-Reply-To: <457fce6a$0$334$e4fe514c@news.xs4all.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote on Wednesday, December 13, 2006 1:57 AM
> Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> >This rawio test plows through sequential I/O and modulo each small record
> >over number of threads.  So each thread appears to be non-contiguous within
> >its own process context, overall request hitting the device are sequential.
> >I can't see how any application does that kind of I/O pattern.
> 
> A NNTP server that has many incoming connections, handled by
> multiple threads, that stores the data in cylic buffers ?

Then whichever the thread that dumps the buffer content to the storage
will do one large contiguous I/O.
