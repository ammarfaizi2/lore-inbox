Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSAICwn>; Tue, 8 Jan 2002 21:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSAICwc>; Tue, 8 Jan 2002 21:52:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8708 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288734AbSAICwY>; Tue, 8 Jan 2002 21:52:24 -0500
Message-ID: <3C3BB05D.1040501@zytor.com>
Date: Tue, 08 Jan 2002 18:52:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: can we make anonymous memory non-EXECUTABLE?
In-Reply-To: <Pine.LNX.4.33L.0201090049390.2985-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On 8 Jan 2002, H. Peter Anvin wrote:
> 
> 
>>One way to do this would be to create a newbrk() syscall which takes a
>>permission argument (for new pages.)
>>
> 
> ITYM mmap(2)
> 


That's an idea, too.  WTF do we actually need brk() for?  If it's only 
there to be annoying, let's get rid of it completely and let the C 
library implement it -- stating its assumptions explicitly.

	-hpa



