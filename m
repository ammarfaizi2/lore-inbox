Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbULNP1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbULNP1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbULNP1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:27:44 -0500
Received: from web51509.mail.yahoo.com ([206.190.38.201]:61522 "HELO
	web51509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261529AbULNP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:27:31 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=swRYfgj6b8LS1W8tcaEGb7aueo+Lue5K4YreyiiN1IP9WhnggYdthbbEwVesZuobyxyiunpHgkjQY0Eq20QuRF/qMgTWxIOYFnQh2+sk86RSyxjgEA0P821ulFFPQsiOSUKBkOH04cTBOrohHq6cdhqRac55oHqRCnDArfeUpj8=  ;
Message-ID: <20041214152730.74648.qmail@web51509.mail.yahoo.com>
Date: Tue, 14 Dec 2004 07:27:30 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: How to get the whole information dumped from kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  Sat, 11 Dec 2004 at 10:53, Linus Torvalds wrote:
>
> - for one-off things where you don't want to go to
the bother, but
> just want to find one problem, you can do:
>      [snipped]     
>    - disable CONFIG_CALLSYM, which makes the oops
much harder to
>      read, but also more compact. Then look up the
addresses by hand
>      with "gdb vmlinux" or use the ksymoops program.
>
 
Thank you.
 
In /usr/src/linux/.config, we can see that
"CONFIG_KALLSYMS=y" is included in the General setup
section like the following: 
 
#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 
But, when we run 'make menuconfig', we can only see
that the General setup section only contains the
following items:
  
  [*] Support for paging of anonymous memory (swap)   

  [*] System V IPC                                 
  [*] POSIX Message Queues                         
  [*] BSD Process Accounting                          
   
  [*] Sysctl support                                  
     
  [*] Auditing support                                
     
  [*]   Enable system-call auditing support           
      
  (17) Kernel log buffer size (16 => 64KB, 17 =>
128KB)        
  [*] Support for hot-pluggable devices               
          
  [ ] Kernel .config support                          
         
  [ ] Configure standard kernel features (for small
systems)  ---> 
  [*] Optimize for size                               
 
Then, It seems that there is no place to disable
CONFIG_KALLSYMS (i.e. turn 'CONFIG_KALLSYMS=y' to
'CONFIG_KALLSYMS is not set'), How can I turn off the
'CONFIG_KALLSYMS' item?? Is CONFIG_KALLSYMS=y set
automatically by system?

Thanks,



=====
--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 







__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
