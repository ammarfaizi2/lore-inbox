Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131203AbQLGQoe>; Thu, 7 Dec 2000 11:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbQLGQoY>; Thu, 7 Dec 2000 11:44:24 -0500
Received: from Cantor.suse.de ([194.112.123.193]:34568 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131187AbQLGQoV>;
	Thu, 7 Dec 2000 11:44:21 -0500
Date: Thu, 7 Dec 2000 17:13:53 +0100
From: Andi Kleen <ak@suse.de>
To: richardj_moore@uk.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
Message-ID: <20001207171353.A28798@gruyere.muc.suse.de>
In-Reply-To: <802569AE.00588787.00@d06mta06.portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <802569AE.00588787.00@d06mta06.portsmouth.uk.ibm.com>; from richardj_moore@uk.ibm.com on Thu, Dec 07, 2000 at 04:04:21PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 04:04:21PM +0000, richardj_moore@uk.ibm.com wrote:
> 
> 
> Why is double_fault serviced by a trap gate? The problem with this is that
> any double-fault caused by a stack-fault, which is the usual reason,
> becomes a triple-fault. And a triple-fault results in a processor reset or
> shutdown making the fault damn near impossible to get any information on.
> 
> Oughtn't the double-fault exception handler be serviced by a task gate? And
> similarly the NMI handler in case the NMI is on the current stack page
> frame?

Sounds like a good idea, when you can afford a few K for a special
NMI/double fault stack. On x86-64 it is planned to do that.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
