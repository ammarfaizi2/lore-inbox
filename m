Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbUKXOJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbUKXOJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUKXOGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:06:35 -0500
Received: from zeus.kernel.org ([204.152.189.113]:25549 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262709AbUKXNjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:39:39 -0500
Message-ID: <41A48395.60100@sgi.com>
Date: Wed, 24 Nov 2004 06:50:29 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 0.9 (Macintosh/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
CC: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
References: <200411221530.30325.lkml@kcore.org> <20041122155106.GG2714@holomorphy.com> <41A30D3E.9090506@gmx.de> <20041124082736.E6205230@wobbly.melbourne.sgi.com> <41A44071.9040101@gmx.de>
In-Reply-To: <41A44071.9040101@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Nathan Scott schrieb:
> 
>> Did you see
>> any of those device errors since switching to ext3?
> 
> 
> No. That's why I am wondering. I read about such errors like I got 
> before in lkml and usually they were not fs related but libata siimage 
> driver related. It could be just a coincidence that it came up with xfs, 
> but till now (I guess 5 days now, though not 24/7 running) ext3 is 
> behaving nicely.

It's almost certainly not a filesystem problem, but an IO layer problem. 
  Maybe you only see it with xfs due to different disk IO patterns with 
xfs vs. ext3...  the two will certainly be allocating & writing to the 
disk in different ways.

-Eric
