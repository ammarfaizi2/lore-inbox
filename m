Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbSKLXPf>; Tue, 12 Nov 2002 18:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267012AbSKLXPf>; Tue, 12 Nov 2002 18:15:35 -0500
Received: from holomorphy.com ([66.224.33.161]:29373 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267010AbSKLXPe>;
	Tue, 12 Nov 2002 18:15:34 -0500
Date: Tue, 12 Nov 2002 15:19:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112231937.GB23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112225937.GA23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 03:53:49PM -0800, Martin J. Bligh wrote:
>> Right, I'm not against the sysdata thing, seems like a much better way
>> to do it in general (what I did was a quick hack). Was just confused
>> by the global bus number assertion, but if we use the sysdata stuff,
>> it's all a non-issue ;-)

On Tue, Nov 12, 2002 at 02:59:37PM -0800, William Lee Irwin III wrote:
> Non-issue for merging...
> The pain isn't over yet. =(
> Core PCI code is assuming unique bus numbers in several places.
> Fixing now,
> Bill

... and resource/region stuff is not being dealt with properly either.

Found that after dealing with pci_bus_exists() in pci_alloc_primary_bus().


Fixing that too,
Bill
