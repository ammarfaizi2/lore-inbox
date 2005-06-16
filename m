Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVFPWrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVFPWrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFPWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:44:12 -0400
Received: from holomorphy.com ([66.93.40.71]:13544 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261871AbVFPWmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:42:43 -0400
Date: Thu, 16 Jun 2005 15:42:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
Message-ID: <20050616224230.GD3913@holomorphy.com>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com> <20050616002451.01f7e9ed.akpm@osdl.org> <1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 12:50:59PM -0700, Badari Pulavarty wrote:
> Yes. I am using CFQ scheduler. I changed nr_requests to 4 for all
> my devices. I also changed "min_free_kbytes" to 64M.
> Response time is still bad. Here is the vmstat, meminfo, slabinfo
> and profle output. I am not sure why profile output shows 
> default_idle(), when vmstat shows 100% CPU sys.

It's because you're sorting on the third field of readprofile(1),
which is pure gibberish. Undoing this mistake will immediately
enlighten you.

Also, turn off slab poisoning when doing performance analyses.


-- wli
