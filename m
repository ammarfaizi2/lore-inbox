Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWJMK0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWJMK0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWJMK0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:26:12 -0400
Received: from farad.aurel32.net ([82.232.2.251]:4009 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S1751154AbWJMK0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:26:11 -0400
Message-ID: <452F69AD.8000902@aurel32.net>
Date: Fri, 13 Oct 2006 12:25:49 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
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
> 

Nice to see there is already a patch! Thanks for your work. Do you know 
when the patch will be merged upstream or in Debian? I really want to 
see this bug fixed, as it breaks dchroot.

-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
