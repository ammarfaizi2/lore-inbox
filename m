Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWHCXbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWHCXbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHCXbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:31:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14257 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932536AbWHCXbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:31:03 -0400
Date: Thu, 3 Aug 2006 19:30:48 -0400
From: Dave Jones <davej@redhat.com>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [1/2] Remove Deadline I/O scheduler
Message-ID: <20060803233048.GA7265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:57:32PM -0700, Nate Diller wrote:
 > This patch removes the Deadline I/O scheduler.  Performance-wise, it
 > should be superceeded by the Elevator I/O scheduler in the following
 > patch.  I would be very ineterested in hearing about any workloads or
 > benchmarks where Deadline is a substantial improvement over Elevator,
 > in throughput, fairness, latency, anything.

Its somewhat hard for folks to offer comparative benchmarks when you
remove something.  Without any numbers at all showing why your elevator
is superior, removing anything seems very premature.

I'm also not convinced that removing an elevator at all is a good idea,
as it'll cause regressions for anyone who has boot scripts that set
certain mounts to use deadline for eg.

		Dave
-- 
http://www.codemonkey.org.uk
