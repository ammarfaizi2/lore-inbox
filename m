Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVI0Shp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVI0Shp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVI0Shp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:37:45 -0400
Received: from smtpout.mac.com ([17.250.248.46]:15350 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965037AbVI0Sho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:37:44 -0400
In-Reply-To: <20050927175526.GU7992@ftp.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.151301.189720995.takata.hirokazu@renesas.com> <20050927071025.GS7992@ftp.linux.org.uk> <CFD86C0A-0BE4-4D39-BAAE-F985D997AFD2@mac.com> <20050927163455.GT7992@ftp.linux.org.uk> <44F9E519-C94E-422B-9CA7-B24C2F76B78D@mac.com> <20050927175526.GU7992@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3B320087-2A36-4106-AB85-0A1B626234A1@mac.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Date: Tue, 27 Sep 2005 14:37:09 -0400
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27, 2005, at 13:55:26, Al Viro wrote:
> On Tue, Sep 27, 2005 at 01:31:25PM -0400, Kyle Moffett wrote:
>> Why not?  Some of that stuff may get used in kernel headers, which  
>> sparse should definitely have defined.  Besides, sparse is  
>> designed to check C source code, which will be compiled with said  
>> GCC using those preprocessing defines.  Why should it use a  
>> different set of defines?
>
> First of all, some of that stuff should not be used in kernel  
> headers and getting a warning about such uses is a Good Thing(tm).   
> What's more, some are actively *wrong* for kernel -  
> __STDC_HOSTED__, for one, is simply a lie.

So maybe put a "grep" in the middle to select the ones you want or  
"grep -v" to remove the ones you don't?  I don't see why this is such  
a big deal.  There are obviously missing defines that sparse needs to  
correctly operate with kernel headers, and I'm not sure why we should  
specify them in several places in the Makefiles, including one set  
for each arch.?

> And no, sparse (or any other C compiler) is not required to have  
> the same pile as gcc does.

But when we're using sparse to check kernel sources, it should have a  
similar set to what the regular compiler (IE: gcc) has when building  
kernel sources.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


