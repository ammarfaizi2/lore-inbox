Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290574AbSAYFzF>; Fri, 25 Jan 2002 00:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290573AbSAYFy4>; Fri, 25 Jan 2002 00:54:56 -0500
Received: from mail013.syd.optusnet.com.au ([203.2.75.174]:8590 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S290572AbSAYFyo>; Fri, 25 Jan 2002 00:54:44 -0500
Message-ID: <3C50F31F.1090302@bigpond.com>
Date: Fri, 25 Jan 2002 16:54:39 +1100
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.5) Gecko/20011024
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: touch commands in Makefiles
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why are header file touched in Makefiles ?

The reason I ask is that I am using a configuration management system to 
maintain the linux kernel.  It "checks out" all source files read-only 
(actuall it uses symbolic links to a baseline directory which is 
read-only).  You then tell it which files you intend to modify and it 
will check those files out as read-write to the local sandbox.

When trying to do a "make zImage" some of the header files (eg. 
include/linux/types.h) are being touched by a dependency rule.  The 
build is failing as the files are readonly and can't be touched.  I 
don't understand why the header files need to be touched.  Surely the 
"make dep" should only generate rules to recompile .c files.

Thanks for any help explaining why header files need to be touched.
Regards,
Brendan Simon.


