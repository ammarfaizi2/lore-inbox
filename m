Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTDYXqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTDYXqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:46:45 -0400
Received: from holomorphy.com ([66.224.33.161]:52661 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263915AbTDYXqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:46:44 -0400
Date: Fri, 25 Apr 2003 16:58:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: badari <pbadari@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <20030425235843.GU8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	badari <pbadari@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mm mailing list <linux-mm@kvack.org>,
	Andrew Morton <akpm@digeo.com>
References: <459930000.1051302738@[10.10.2.4]> <3EA9CA25.E140A02C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA9CA25.E140A02C@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 04:52:05PM -0700, badari wrote:
> Only problem with moving TASK_UNMAPPED_BASE right above
> text would be - limiting the malloc() space. malloc() is clever enough
> to mmap() and do the right thing. Once I moved TASK_UNMAPPED_BASE
> to 0x10000000 and I could not run some of the programs with large
> data segments.
> Moving stacks below text would be tricky. pthread library knows
> the placement of stack. It uses this to distinguish between
> threads and pthreads manager.
> I don't know what other librarys/apps depend on this kind of stuff.

STACK_TOP is easy to change to see what goes wrong; it's a single
#define in include/asm-i386/a.out.h

Someone should spin it up and see how well pthreads copes.


-- wli
