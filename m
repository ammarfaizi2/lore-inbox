Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTDGUU6 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTDGUU6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:20:58 -0400
Received: from terminus.zytor.com ([63.209.29.3]:48316 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263671AbTDGUU5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:20:57 -0400
Message-ID: <3E91E060.9090307@zytor.com>
Date: Mon, 07 Apr 2003 13:32:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
References: <20030407102005.4c13ed7f.manushkinvv@desnol.ru> <200304070709.h37792815083@mozart.cs.berkeley.edu> <20030407113534.1de8dc91.agri@desnol.ru> <b6s3k4$i0i$1@cesium.transmeta.com> <20030407200533.GA23680@ti19>
In-Reply-To: <20030407200533.GA23680@ti19>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Rugolsky Jr. wrote:
> 
> We discussed this previously; I described the problems with
> existing semantics, and on 2000/020/29 you wrote:
> 
> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=fa.iqoa6kv.flii0q%40ifi.uio.no&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26q%3Dhpa%2Brugolsky%26btnG%3DGoogle%2BSearch
> 
>   "I'm hoping to fix this in 2.5.  The problem is that the way open() is
>   done in the VFS *requires* the creation of a new filestructure."
> 
> I'm still open to suggestions. ;-)
> 

I suggested at one point the following change:

Instead of having the filesystem open() method being passed in a pointer 
to already allocated, partially initialized file structure, that code 
should be moved to a library function, and instead let the open() method 
return a struct file *.  That way open() could either return a reference 
to an already-allocated file or a new one.

	-hpa


