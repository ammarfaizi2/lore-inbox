Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272151AbRIEMth>; Wed, 5 Sep 2001 08:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272156AbRIEMt1>; Wed, 5 Sep 2001 08:49:27 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:16045 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272151AbRIEMtP>;
	Wed, 5 Sep 2001 08:49:15 -0400
Date: Wed, 05 Sep 2001 13:49:30 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: root@chaos.analogic.com,
        =?ISO-8859-1?Q?=22Hammond=2C_Jean-Fran=E7ois=22?= 
	<Jean-Francois.Hammond@mindready.com>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [BUG] Scheduling in interrup
Message-ID: <1268234149.999697770@[169.254.198.40]>
In-Reply-To: <Pine.LNX.3.95.1010905081115.9922A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010905081115.9922A-100000@chaos.analogic.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > o	Are you attempting to access paged RAM?
>>
>> I am using kmalloc to reserve my memory.
>> kmalloc as the options GFP_KERNEL and GFP_DMA.
>> I am not using any command to reserve memory in
>> the interrupt handler.
>>
>
> This is okay. These will not be paged.

Though if you are actually allocating in the
handler (as opposed to merely using) you want
to set GFP_ATOMIC (i.e. make sure __GFP_WAIT
is clear)

--
Alex Bligh
