Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314023AbSDKLDp>; Thu, 11 Apr 2002 07:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314025AbSDKLDo>; Thu, 11 Apr 2002 07:03:44 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:11694 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314023AbSDKLDn>; Thu, 11 Apr 2002 07:03:43 -0400
Message-ID: <3CB56D05.6040702@didntduck.org>
Date: Thu, 11 Apr 2002 07:01:25 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: blesson paul <blessonpaul@msn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: put_user_byte()
In-Reply-To: <F38uSbh29cM3oryKFRJ00031d09@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blesson paul wrote:
> Hi all
>                I need to copy some data from kernel memory space to user 
> memory space. When I investigated, the command for that purpose is 
> put_user_byte(). But in kernel2.4, I can't find the implementation of 
> this command. I want to know the command which replaced put_user_byte() 
> in 2.4 kernel. Also I want to know whether there is any synonyms for 
> verify_area() in kernel 2.4
> regards
> Blesson Paul

Use put_user(val, uaddr).  val must be of type unsigned char (or casted 
to it).  It will return 0 on success or -EFAULT on fault.  verify_area() 
is normally not needed in 2.4, unless you are copying many values to 
user space and only want to do the priviledge check once on the whole range.

-- 

						Brian Gerst

