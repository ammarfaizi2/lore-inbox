Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271552AbRIFRcR>; Thu, 6 Sep 2001 13:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRIFRcI>; Thu, 6 Sep 2001 13:32:08 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:48049 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271574AbRIFRbz>;
	Thu, 6 Sep 2001 13:31:55 -0400
Date: Thu, 06 Sep 2001 18:32:13 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Stephan von Krawczynski <skraw@ithnet.com>
Cc: riel@conectiva.com.br, jaharkes@cs.cmu.edu, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <607043262.999801133@[10.132.112.53]>
In-Reply-To: <20010906172741Z16140-26183+20@humbolt.nl.linux.org>
In-Reply-To: <20010906172741Z16140-26183+20@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, September 06, 2001 7:34 PM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> On September 6, 2001 05:18 pm, Alex Bligh - linux-kernel wrote:
>> --On Thursday, September 06, 2001 5:10 PM +0200 Stephan von Krawczynski
>> <skraw@ithnet.com> wrote:
>>
>> > (or default = 1024) gives such a ridicolously bad
>> > performance
>>
>> I know. I am trying to ensure we have the problem definitively
>> identified, either from /proc/memareas, or by showing it
>> goes away if you change rsize/wsize. I am NOT proposing
>> it as a fix.
>
> Are rsize/wsize expressed in bytes?  In which case you'd want them to be
> 4096  for this test.

Bytes per request. There is some header wastage, so 4096 is too high
as the packets will be slightly larger than a page. I suggested 1024
rather than 2048 as 1024 is the original standard & thus everything
supports it.


--
Alex Bligh
