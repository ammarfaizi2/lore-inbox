Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUFFSKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUFFSKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUFFSKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:10:33 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:65412 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263932AbUFFSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:10:21 -0400
Message-ID: <40C35E36.305@yahoo.fr>
Date: Sun, 06 Jun 2004 20:11:02 +0200
From: Eric BEGOT <eric_begot@yahoo.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre5
References: <20040603022432.GA6039@logos.cnet> <40C08A0D.9010003@yahoo.fr> <20040604225247.GH7744@fs.tum.de> <40C19EDE.10405@yahoo.fr> <20040606121545.GB5830@fs.tum.de>
In-Reply-To: <20040606121545.GB5830@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>>>On Fri, Jun 04, 2004 at 04:41:17PM +0200, Eric BEGOT wrote:
>>>
>>>
>>>      
>>>
>>>>when compiling linux-2.4.27-pre5 under a x86 architecture, I've a lot of 
>>>>warnings :
>>>>
>>>>In file included from 
>>>>/usr/src/devel//usr/src/devel/include/linux/modules/i386_ksyms.ver:127:1: 
>>>>warning: "__ver_atomic_dec_and_lock" redefined
>>>>In file included from /usr/src/devel/include/linux/modversions.h:70,
>>>>             from <command line>:8:
>>>>/usr/src/devel/include/linux/modules/dec_and_lock.ver:1:1: warning: this 
>>>>is the location of the previous definition
>>>>
>>>>__ver_atomic_dec_and_lock is declared two times. Maybe it lacks a #ifdef 
>>>>somewhere in the modversions.h no ?
>>>>The compilation doesn't fail bu it's not very nice :)
>>>>        
>>>>
>
>
>I can't reproduce your problem with your .config .
>
>Did you do something like patching the kernel or changing the SMP option
>without running "make oldconfig" afterwards?
>  
>
no

>What are the values of __ver_atomic_dec_and_lock at the two places
>mentiones in the warnings?
>  
>
in /usr/src/devel/include/linux/modules/i386_ksyms.ver :
#define __ver_atomic_dec_and_lock smp_d43e6bde
in /usr/src/devel/include/linux/modules/dec_and_lock.ver :
#define __ver_atomic_dec_and_lock smp_ad7738e3

>Does a
>  cp .config /tmp
>  make mrproper
>  mv /tmp/.config
>  make oldconfig
>  make bzImage
>fix this problem?
>  
>
apparently the mrproper fixed this problem. Sorry I've maybe forgotten 
to rebuild the configuration after applying the 2.4.27-pre5 patch.
