Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130964AbRBXAdZ>; Fri, 23 Feb 2001 19:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130955AbRBXAdP>; Fri, 23 Feb 2001 19:33:15 -0500
Received: from chiara.elte.hu ([157.181.150.200]:18449 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130949AbRBXAc6>;
	Fri, 23 Feb 2001 19:32:58 -0500
Date: Sat, 24 Feb 2001 01:32:05 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Reto Baettig <baettig@scs.ch>
Cc: MM Linux <linux-mm@kvack.org>, Kernel Linux <linux-kernel@vger.kernel.org>,
        Martin Frey <frey@scs.ch>
Subject: Re: RFC: vmalloc improvements
In-Reply-To: <200102240026.QAA09446@k2.llnl.gov>
Message-ID: <Pine.LNX.4.30.0102240129200.5327-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Feb 2001, Reto Baettig wrote:

> We have an application that makes extensive use of vmalloc (we need
> lots of large virtual contiguous buffers. The buffers don't have to be
> physically contiguous).

question: what is this application, and why does it need so much virtual
memory? vmalloc()-able memory is maximized to 128 MB right now, and
increasing it conflicts with directly mapping RAM, so generally it's a
good idea to avoid vmalloc() as much as possible.

	Ingo

