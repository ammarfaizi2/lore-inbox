Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSJaWJp>; Thu, 31 Oct 2002 17:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSJaWJI>; Thu, 31 Oct 2002 17:09:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:49306 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265389AbSJaWIG>; Thu, 31 Oct 2002 17:08:06 -0500
Subject: Re: Reiser vs EXT3
From: "David C. Hansen" <haveblue@us.ibm.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 14:13:24 -0800
Message-Id: <1036102404.4272.285.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 12:49, David Lang wrote:
> note that breaking up this locking bottleneckhas been done in the 2.5
> kernel series so when 2.6 is released this should be much less significant
> (Q2 2003 is the current thought, but don't count on it until it's out)

Actually, ext3 has been immune from most of the lock breakups in 2.5. 
ext2 used to have a lot of problems with BKL contention resulting from 
ext2_get_block() and some other assorted functions.  Al Viro cleaned
these up in early 2.5, but ext3 never got the cleanup.  It still scales
horribly, even 2.5.45.  

-- 
Dave Hansen
haveblue@us.ibm.com

