Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSKLWxf>; Tue, 12 Nov 2002 17:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSKLWxf>; Tue, 12 Nov 2002 17:53:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:27344 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267019AbSKLWxe>; Tue, 12 Nov 2002 17:53:34 -0500
Date: Tue, 12 Nov 2002 15:53:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <179150000.1037145229@flay>
In-Reply-To: <20021112215305.GZ23425@holomorphy.com>
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Also, every PCI bridge in my box has a bus number of 3 so the lookup
>>> table will produce wrong answers every time.
> 
> On Tue, Nov 12, 2002 at 02:46:29PM -0800, Martin J. Bligh wrote:
>> Isn't that the local bus number though? The topology functions take
>> global bus numbers, which should be unique ...
>> M.
> 
> That bus number mangling scheme is an instance of an approach vetoed
> over a year ago by Dave Miller and others, and does not work for bridges
> because arch code does not get the opportunity to mangle the bus number
> during bridge discovery.

Right, I'm not against the sysdata thing, seems like a much better way
to do it in general (what I did was a quick hack). Was just confused
by the global bus number assertion, but if we use the sysdata stuff,
it's all a non-issue ;-)

M.

