Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTLJXlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTLJXly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:41:54 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:45521 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S264274AbTLJXl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:41:28 -0500
Date: Wed, 10 Dec 2003 15:30:35 -0800
From: Hui Huang <Hui.Huang@Sun.COM>
Subject: Re: 2.6.0-test11 java application memory usage
In-reply-to: <200312082320.40045.edt@aei.ca>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, hemp4fuel <hemp4fuel@kc.rr.com>
Message-id: <3FD7AC9B.2050204@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.3) Gecko/20030314
References: <3FD51FDC.30904@kc.rr.com> <200312082320.40045.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> On December 08, 2003 08:05 pm, hemp4fuel wrote:
> 
>>I am running 2.6.0-test11 with a duron 1.3ghz with 630mb ram using
>>reiserfs and suns 1.4.2_01 jre, with 2.4.xx kernels the java based
>>application I run used around 35-50mb memory, with the 2.6.0-test11 it
>>goes right to 250mb and rises from there.  When I revert back to 2.4.23
>>it is back to 35-50mb memory usage.
> 
> 
> Problems like this have been seen within the freenet project.  Are you using
> an NTPL enabled libc?  If so that is probably the problem.  It would seem that
> sun java does not yet like NTPL.
> 

There is a known memory leak when creating tens of thousands of
threads on RHEL AS3 (NPTL-0.60). It's fixed in 1.4.2_04, which
should get released early next year. Also I've been told by Ulrich
that it's fixed on libc side too.

It's likely something else if you don't create that many of
threads. Send me an email if you have a testcase.

regards,
-hui

