Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbSKLWzx>; Tue, 12 Nov 2002 17:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267012AbSKLWzx>; Tue, 12 Nov 2002 17:55:53 -0500
Received: from holomorphy.com ([66.224.33.161]:23485 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266998AbSKLWzX>;
	Tue, 12 Nov 2002 17:55:23 -0500
Date: Tue, 12 Nov 2002 14:59:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112225937.GA23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179150000.1037145229@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> That bus number mangling scheme is an instance of an approach vetoed
>> over a year ago by Dave Miller and others, and does not work for bridges
>> because arch code does not get the opportunity to mangle the bus number
>> during bridge discovery.

On Tue, Nov 12, 2002 at 03:53:49PM -0800, Martin J. Bligh wrote:
> Right, I'm not against the sysdata thing, seems like a much better way
> to do it in general (what I did was a quick hack). Was just confused
> by the global bus number assertion, but if we use the sysdata stuff,
> it's all a non-issue ;-)

Non-issue for merging...

The pain isn't over yet. =(

Core PCI code is assuming unique bus numbers in several places.


Fixing now,
Bill
