Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270338AbTHGTgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbTHGTgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:36:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270338AbTHGTgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:36:47 -0400
Date: Thu, 7 Aug 2003 20:36:43 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH][2.6-mm] Readahead issues and AIO read speedup
Message-ID: <20030807193641.GM3164@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Andrew Morton <akpm@osdl.org>,
	Badari Pulavarty <pbadari@us.ibm.com>, suparna@in.ibm.com,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org
References: <20030807100120.GA5170@in.ibm.com> <200308070901.01119.pbadari@us.ibm.com> <20030807092800.58335e84.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807092800.58335e84.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 09:28:00AM -0700, Andrew Morton wrote:
> If the database pagesize is 16k then the application should be submitting
> 16k reads, yes?  If so then these should not be creating 4k requests at the
> device layer!  So what we need to do is to ensure that at least those 16k

	Um, I thought bio enforced single CDB I/O for contiguous chunks
of disk!  If it doesn't, 2.6 is just as lame as 2.4.

Joel

-- 

"Three o'clock is always too late or too early for anything you
 want to do."
        - Jean-Paul Sartre

			http://www.jlbec.org/
			jlbec@evilplan.org
