Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSFMAv7>; Wed, 12 Jun 2002 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSFMAv6>; Wed, 12 Jun 2002 20:51:58 -0400
Received: from cm61-15-171-191.hkcable.com.hk ([61.15.171.191]:37248 "EHLO
	host1.home.shaolinmicro.com") by vger.kernel.org with ESMTP
	id <S317386AbSFMAv5>; Wed, 12 Jun 2002 20:51:57 -0400
Message-ID: <3D07ECAB.2010303@shaolinmicro.com>
Date: Thu, 13 Jun 2002 08:51:55 +0800
From: David Chow <davidchow@shaolinmicro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: raid 0+1 issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I find the raidtools-1 (comes with Redhat 7.3) doesn't allow you to run 
raid 0+1. Here is the problem .

I have 2 raid 0 devices /dev/md2 /dev/md3 and then I run raid 1 ontop of 
these raid 0 devices (/dev/md4).

The md2 and md3 sucessfully started, but when come to md4 raidstart 
always return "invalid argument" . The point is that the partition has 
already initialised, but if you run "raidstop /dev/md4" and then it 
cannot start again. If you run "'mkraid /dev/md4" it will initialise the 
raid and start automatically, that means there are some problems that 
the "raidstart" command does not allow raidstart on md devices but the 
mkraid allows you to do that. If anyone have experience please comment 
and advice. Thanks.

regards,
David

