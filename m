Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWBCQjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWBCQjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWBCQjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:39:04 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59868 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751065AbWBCQjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:39:03 -0500
Message-ID: <43E386F5.6090305@cfl.rr.com>
Date: Fri, 03 Feb 2006 11:38:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Bill Davidsen <davidsen@tmr.com>, Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org> <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz> <43E26CB6.7030808@tmr.com> <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz> <43E379C2.2020607@cfl.rr.com> <Pine.LNX.4.60.0602031654520.24081@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0602031654520.24081@kepler.fjfi.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 16:39:35.0007 (UTC) FILETIME=[6A6ECEF0:01C628E0]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--9.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab wrote:
> On Fri, 3 Feb 2006, Phillip Susi wrote:
>   
>> It looks like the problem is in that controller card and its driver.  Was this
>> a proprietary closed source driver?
>>     
>
> No, it was the kernel's AACRAID driver (drivers/scsi/aacraid/*). And I've 
> consulted that with Mark Salyzyn who told me that it is the problem of the 
> upper layers which are only zero fault tollerant and that driver con do 
> nothing about it.
>   

That's a strange statement, maybe we could get some clarification on 
it?  From the dmesg lines you posted before, it appeared that the 
hardware was failing the request with a bad disk sense code.  As I said 
before, normally Linux has no problem reading the good parts of a 
partially bad disk, so I wonder exactly what Mark means by "upper layers 
which are only zero fault tollerant"?



