Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289160AbSAJEcI>; Wed, 9 Jan 2002 23:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSAJEbs>; Wed, 9 Jan 2002 23:31:48 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:25985 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S289160AbSAJEbj>;
	Wed, 9 Jan 2002 23:31:39 -0500
Message-ID: <3C3D19AD.60306@acm.org>
Date: Wed, 09 Jan 2002 22:33:49 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
In-Reply-To: <25006.1010627525@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>>
>> I'm working on a function that uses zlib in the kernel, and I know of 
>> other places zlib is used (ppp_deflate, jffs2, mcore).  I would expect 
>> more users to come along.
>> 
>
>CAREFUL.  First of all, don't mix up the deflate and inflate
>functions, second of all, make sure you get the memory management
>right.  It's not trivial to do the latter, since the default zlib
>memory management is unusable for at least some users in kernelspace.

I'm not sure I follow you here.  Do you want to completely separate the
inflate and deflate stuff (so if something only needs one, it only has
to include one)?  I'm not sure of the value, and it would be kind of a
pain for maintenance (since zlib is from an external source).

As far as memory management, all the versions I am talking about are
almost exactly the same, so that shouldn't be a problem.

-Corey


