Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbSJIMcP>; Wed, 9 Oct 2002 08:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261676AbSJIMbz>; Wed, 9 Oct 2002 08:31:55 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:61122 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261623AbSJIMbI>; Wed, 9 Oct 2002 08:31:08 -0400
Message-ID: <3DA42315.9020308@quark.didntduck.org>
Date: Wed, 09 Oct 2002 08:37:41 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lell02 <lell02@stud.uni-passau.de>
CC: Jens Axboe <axboe@suse.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of UDF CD packet writing?
References: <200210091042.g99Agwjm009964@tom.rz.uni-passau.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lell02 wrote:
>>On Tue, Oct 08 2002, lell02 wrote:
>>
>>>hi, 
>>>
>>>
>>>>Will Jens Axboes patch for CD packet writing for CD-R/RW make it in
>>>>before the feature freeze? I know Jens Axboe is busy with more basic I/O
>>>>stuff, but i sincerely hope it can be squeezed in before 2.6/3.0 is
>>>>released.
>>>
>>>jens stated on this about 1-2 days ago. he said, it would be little
>>>modification on the ide-cdrom, to make it work with cd-mrw/ packet
>>>writing.  so it could go in after the feature freeze.
>>
>>You might be talking about two different patches -- one for cd-rw
>>support (this is the pktcdvd (or -packet) patch that Peter Osterlund has
>>been maintaining) and the other for cd-mrw. The cd-mrw patch is very
>>small, not a lot is required to support that in the cd driver.
>>Supporting cd-rw is a lot harder, basically you have to do in software
>>what cd-mrw does in hardware (defect management, read-modify-write
>>packet gathering, etc).
>>
>>cd-mrw will definitely be in 2.6. cd-rw support maybe, I haven't even
>>looked at that lately.
>>
> 
> 
> thanx for clearing out these differences. 
> 
> but, isn't cd-mrw supposed to replace the old packet-writing technique?
> so, in the end, there wouldn't be any need for packet-writing, if every burner 
> ships with cd-mrw-support... i read in the "specs", that the technology would 
> be much better.

For drives that support cd-mrw.  Older cd-rw drives will still need the 
full blown packet writing patch though.

--
				Brian Gerst


