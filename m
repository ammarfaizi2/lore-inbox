Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTKZNV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTKZNVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:21:55 -0500
Received: from holomorphy.com ([199.26.172.102]:36285 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262750AbTKZNVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:21:53 -0500
Date: Wed, 26 Nov 2003 05:21:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
Message-ID: <20031126132144.GN8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031125211518.6f656d73.akpm@osdl.org> <20031126085123.A1952@infradead.org> <20031126044251.3b8309c1.akpm@osdl.org> <20031126130936.A5275@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126130936.A5275@infradead.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 04:42:51AM -0800, Andrew Morton wrote:
>> The individual patches in the broken-out/ directory are usually
>> changelogged.  This one says:
>>   It was EXPORT_SYMBOL_GPL(), however IBM's GPFS is not GPL.
>>   - the GPFS team contributed to the testing and development of
>>     invaldiate_mmap_range().
>>   - GPFS was developed under AIX and was ported to Linux, and hence meets
>>     Linus's "some binary modules are OK" exemption.
>>   - The export makes sense: clustering filesystems need it for shootdowns to
>>     ensure cache coherency.

On Wed, Nov 26, 2003 at 01:09:36PM +0000, Christoph Hellwig wrote:
> Have you actually looked at the gpfs glue code? something that digs that deep
> into the VM and VFS actually _must_ be derived work.  Or do wed allow people
> now to pay a developer tax to buy themselves free from GPL restrictions.
> I as one of the collective copytight holders of the kernel strongly disagree
> with that, it can't be true that IBM can just ignore copyright law..

I'm not one to toe the party line, but this really does seem innocuous
and of more general use than GPFS. I'd say walking pagetables directly
in fs and/or device drivers is more invasive wrt. VM internals than
calling a well-established procedure, but that's just me.

-- wli
