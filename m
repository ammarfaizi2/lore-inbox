Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSKMAId>; Tue, 12 Nov 2002 19:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbSKMAId>; Tue, 12 Nov 2002 19:08:33 -0500
Received: from holomorphy.com ([66.224.33.161]:44733 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266971AbSKMAIc>;
	Tue, 12 Nov 2002 19:08:32 -0500
Date: Tue, 12 Nov 2002 16:12:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Greg KH <greg@kroah.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com, mochel@osdl.org
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021113001246.GC23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com, mochel@osdl.org
References: <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com> <20021112235824.GG22031@holomorphy.com> <20021113000435.GE32274@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113000435.GE32274@kroah.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 03:58:24PM -0800, William Lee Irwin III wrote:
>> Okay, an attempt to remedy this world-breaking braindamage with the
>> fewest lines of code:
>> This alters PCI bus number "clash" detection to compare ->sysdata in
>> addition to the numbers. The bus number is not a unique identifier.

On Tue, Nov 12, 2002 at 04:04:35PM -0800, Greg KH wrote:
> Um, why not?
> And what would /sys/bus/pci/devices look like if you allow the same
> identifiers for different devices?  :)
> thanks,
> greg k-h

(1) incorrect semantics:
	multiple domains/segments exist, and the bus number is not
	qualified with such
(2) insufficient cardinality:
	even in the presence of remapping schemes the bus space is limited
	to less than the number of buses requiring unique identifiers


Bill
