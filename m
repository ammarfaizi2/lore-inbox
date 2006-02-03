Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945918AbWBCTjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbWBCTjL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945920AbWBCTjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:39:11 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:47120 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1945918AbWBCTjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:39:09 -0500
Message-ID: <43E3B12A.1080901@cfl.rr.com>
Date: Fri, 03 Feb 2006 14:38:18 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: "'Martin Drab'" <drab@kepler.fjfi.cvut.cz>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Cynbe ru Taren'" <cynbe@muq.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <EXCHG2003ok84FTA7OI000011ea@EXCHG2003.microtech-ks.com>
In-Reply-To: <EXCHG2003ok84FTA7OI000011ea@EXCHG2003.microtech-ks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 19:39:42.0718 (UTC) FILETIME=[9454A1E0:01C628F9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--22.000000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fail to see how this is a reply to my message.  I was asking for 
clarification on what "higher layer" supposedly resulted in this 
behavior ( of not being able to access any part of the disk ) because as 
far as I know, all the higher layers are quite happy to access the non 
broken parts of the disk, and return the appropriate error to the 
calling application for the bad parts of the disk. 

Roger Heflin wrote:
>> That's a strange statement, maybe we could get some 
>> clarification on it?  From the dmesg lines you posted before, 
>> it appeared that the hardware was failing the request with a 
>> bad disk sense code.  As I said before, normally Linux has no 
>> problem reading the good parts of a partially bad disk, so I 
>> wonder exactly what Mark means by "upper layers which are 
>> only zero fault tollerant"?
>>     
>
>
> Some of the fakeraid controllers will kill the disk when the
> disk returns a failure like that.
>
> On top of that usually (even if the controller were not to
> kill the disk) the application will get a fatal disk error
> also, causing the application to die.
>
> The best I have been able to hope for (this is a raid0 stripe
> case) is that the fakeraid controller does not kill the disk,
> returns the disk error to the higher levels and lets the application
> be killed, at least in this case you will likely know the disk
> has a fatal error, rather than (in the raid0 case) having the
> machine crash, and have to debug it to determine exactly
> what the nature of the failure was.
>
> The same may need to be applied when the array is already
> in degraded mode ... limping along with some lost data and messages
> indicating such is a lot better that losing all of the data.
>
>                            Roger

