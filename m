Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSDROA2>; Thu, 18 Apr 2002 10:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314356AbSDROA1>; Thu, 18 Apr 2002 10:00:27 -0400
Received: from holomorphy.com ([66.224.33.161]:33949 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314358AbSDROAZ>;
	Thu, 18 Apr 2002 10:00:25 -0400
Date: Thu, 18 Apr 2002 06:59:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020418135931.GU21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <1589.1019123186@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 07:46:26PM +1000, Keith Owens wrote:
> The use of __init and __exit sections breaks the assumption that tables
> such as __ex_table are sorted, it has already broken the dbe table in
> mips on 2.5.  This patch against 2.5.8 adds a generic sort routine and
> sorts the i386 exception table.
> This sorting needs to be extended to several other tables, to all
> architectures, to modutils (insmod loads some of these tables for
> modules) and back ported to 2.4.  Before I spend the rest of the time,
> any objections?

It doesn't have to be an O(n lg(n)) method but could you use something
besides bubblesort? Insertion sort, selection sort, etc. are just as
easy and they don't have the horrific stigma of being "the worst sorting
algorithm ever" etc.


Thanks,
Bill
