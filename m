Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTKTVfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTKTVfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:35:36 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:64523 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S262153AbTKTVff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:35:35 -0500
Message-ID: <3FBD328C.1070607@techsource.com>
Date: Thu, 20 Nov 2003 16:30:52 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Justin Cormack <justin@street-vision.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby> <20031120172143.GA7390@deneb.enyo.de> <03112013081700.27566@tabby> <1069357453.26642.93.camel@lotte.street-vision.com> <3FBD27A0.50803@techsource.com> <20031120140739.I20568@schatzie.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andreas Dilger wrote:
> On Nov 20, 2003  15:44 -0500, Timothy Miller wrote:
> 
>>This could be a problem if COW causes you to run out of space when 
>>writing to the file.
> 
> 
> Not much different than running out of space copying a file.

It is, though.  If you run out of space copying a file, you know it when 
you're copying.  Applications don't usually expect to get out-of-space 
errors while overwriting something in the middle of a file.

In effect, your free space and your used space add up to greater than 
the capacity of the disk.  An application that checks for free space 
before doing something would be fooled into thinking there is more free 
space than there really is.  How can an application find out in advance 
that a file that it's about to modify (without appending anything to the 
end) is going to need more disk space?


