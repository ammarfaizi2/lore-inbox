Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264805AbUD1OI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264805AbUD1OI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbUD1OI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:08:57 -0400
Received: from mail.tmr.com ([216.238.38.203]:46088 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264805AbUD1OHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:07:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: bug in include file!?
Date: Wed, 28 Apr 2004 10:08:56 -0400
Organization: TMR Associates, Inc
Message-ID: <c6odm2$57s$1@gatekeeper.tmr.com>
References: <20040426203710.GA3005@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1083161090 5372 192.168.12.100 (28 Apr 2004 14:04:50 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040426203710.GA3005@matrix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

csg69@mailbox.hu wrote:
> Dear Linux Kernel Stuff!
> 
> 
> I encountered a strange error recently, when I tried to
> compile cdrtools-2.00.3 on my system (debian woody 3.0,
> kernel 2.6.5, gcc 2.95.4, make 3.79.1).
> 
> The bug is in line 217 in /usr/src/linux/include/scsi/scsi.h
> gcc says: parse error before u8
> (I think everything is OK there)
> 
> Finally I solved the problem by changing the value
> in cdrtools-2.00.3/DEFAULTS/Defaults.linux
> 
> from the original:
> DEFINCDIRS=	$(SRCROOT)/include /usr/src/linux/include
> 
> to:
> DEFINCDIRS=	$(SRCROOT)/include /usr/include
> 
> 
> It seems that in /usr/include/scsi/scsi.h everything is OK...
> 
> 
> It may be the error of the makefiles or the kernel include files...
> 
> Joerg Schilling (schilling@fokus.fraunhofer.de) advised me
> to send to you this report.
> He thinks this is a bug in kernel include files.

I believe he has set this up so that it won't compile correctly unless 
you have a source tree at /usr/src/linux, and then he uses the includes 
there. He has ignored being told this is not the proper way to do things.

It may be an unrelated problem, but I think he regards ever case where 
the kernel people didn't do things for his convenience as a bug, and 
writes his code to cause problems if you don't do it his way.

If you do audio burns it's worth fighting, they use DMA with the ATA: 
interface. For data the last time I used ide-scsi it was working again, 
although it's not the preferred way to operate. YMMV.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
