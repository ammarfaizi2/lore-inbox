Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289356AbSAJGJl>; Thu, 10 Jan 2002 01:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289351AbSAJGJb>; Thu, 10 Jan 2002 01:09:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289350AbSAJGJW>; Thu, 10 Jan 2002 01:09:22 -0500
Message-ID: <3C3D2FF9.8040405@zytor.com>
Date: Wed, 09 Jan 2002 22:08:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Corey Minyard <minyard@acm.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
In-Reply-To: <25006.1010627525@kao2.melbourne.sgi.com> <3C3D19AD.60306@acm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard wrote:

> 
> I'm not sure I follow you here.  Do you want to completely separate the
> inflate and deflate stuff (so if something only needs one, it only has
> to include one)?  I'm not sure of the value, and it would be kind of a
> pain for maintenance (since zlib is from an external source).
> 
> As far as memory management, all the versions I am talking about are
> almost exactly the same, so that shouldn't be a problem.
> 


It is external, but it's quite well separated anyway.

Look at the inflate_fs one (fs/inflate_fs); it has both the memory 
management dealt with and decompression factored out...

	-hpa



