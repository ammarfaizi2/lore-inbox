Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272082AbRHVTAI>; Wed, 22 Aug 2001 15:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272084AbRHVS77>; Wed, 22 Aug 2001 14:59:59 -0400
Received: from mail2.svr.pol.co.uk ([195.92.193.210]:47464 "EHLO
	mail2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S272082AbRHVS7s>; Wed, 22 Aug 2001 14:59:48 -0400
Message-ID: <3B84012D.1010303@humboldt.co.uk>
Date: Wed, 22 Aug 2001 19:59:57 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filling holes in ext2
In-Reply-To: <3B83E9FD.6020801@humboldt.co.uk> <3B83FB3F.A0BDC056@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Adrian Cox wrote:

>>Can this actually be exploited?  I assume the test on __copy_from_user()
>>is there in case another thread changes memory mappings while
>>generic_file_write() is running. My attempts to do this haven't yet
>>succeeded.
> I'd expect it to occur if you simply pass an unmapped address
> to write()?

No, because the first thing generic_file_write does is an access_ok() 
check. It can only happen if the permissions change during the function. 
That's why it's hard to exploit for real.

-- 
Adrian Cox   http://www.humboldt.co.uk/

