Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292858AbSCFBS2>; Tue, 5 Mar 2002 20:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSCFBST>; Tue, 5 Mar 2002 20:18:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:18592 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292858AbSCFBSH>; Tue, 5 Mar 2002 20:18:07 -0500
Message-ID: <3C856E42.50304@us.ibm.com>
Date: Tue, 05 Mar 2002 17:17:54 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] remove BKL from ext2_get_block() version 2
In-Reply-To: <E16iPdM-0004x1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I certainly am not interested in it. 2.4 locking changes for very big boxes
> strike me as a little dangerous.

I think that I may have presented the patch in the wrong way.  The 
primary reason I'm doing this is BKL removal.  The ext2 code just 
happened to be one of the worst offenders that I'd run into.  I've been 
using the 8-way with dbench because it produces a the worst-case 
scenario I can think of.  I also like watching it compile kernels in 
just over a minute.  :)

This patch was also a backport of an Al Viro 2.5 change, so I consider 
it pretty safe.  Only time and testing can tell, but I've tested it 
about as much as I can.

All of this becomes pretty academic if Al decides that he will backport 
the 2.5 changes, which we all want to see.

-- 
Dave Hansen
haveblue@us.ibm.com

