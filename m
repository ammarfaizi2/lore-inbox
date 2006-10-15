Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWJOVMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWJOVMB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWJOVMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:12:01 -0400
Received: from farad.aurel32.net ([82.232.2.251]:54721 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S1030288AbWJOVMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:12:01 -0400
Message-ID: <4532A415.1080801@aurel32.net>
Date: Sun, 15 Oct 2006 23:11:49 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Thiemo Seufer <ths@networkno.de>
CC: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: SYS_personality does not work correctly on mips(el)64
References: <452EB653.7070604@aurel32.net> <20061013095206.GA4027@networkno.de>
In-Reply-To: <20061013095206.GA4027@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thiemo Seufer a écrit :
> Aurelien Jarno wrote:
>> Hi all,
>>
>> On mips(el), when doing multiple call to the syscall SYS_personality in 
>> order to get the current personality (using 0xffffffff for the first 
>> argument), on a 64-bit kernel, the second and subsequent syscalls are 
>> failing. That works correctly with a 32-bit kernels and on other 
>> architectures.
> 
> That's caused by mis-handling broken sign extensions, see also
> http://bugs.debian.org/380531.

I still got the exact same problem with this patch applied.

-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
