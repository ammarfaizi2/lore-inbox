Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314049AbSEAVBn>; Wed, 1 May 2002 17:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSEAVBm>; Wed, 1 May 2002 17:01:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42767 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314049AbSEAVBl>;
	Wed, 1 May 2002 17:01:41 -0400
Message-ID: <3CD057BE.2050603@mandrakesoft.com>
Date: Wed, 01 May 2002 17:01:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alternative API for raw devices
In-Reply-To: <Pine.GSO.4.21.0205011555450.12640-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>Actual IO code is pretty much copied from old driver.  The main differences:
>	* device is originally created with ownership/permissions of the
>	  block device we'd used; you can chmod/chown it at any time,
>	  obviously.
>

Tangent a little bit to partitions.

Consider a filesystem which creates device nodes for N partitions on a 
spindle, "msdos_partition_fs".  In a discussion a while back on 
permissions, you suggested that inheriting permissions from the base 
block device was the wrong way to go, and that (for now)  'uid' and 
'gid' mount options were the best route.

Is inheriting permissions coming back into style?  Or am I reading too 
much into the permissions scheme you describe above?

    Jeff




