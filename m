Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUJFHwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUJFHwB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUJFHwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:52:01 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:44299 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S269113AbUJFHvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:51:32 -0400
Message-ID: <4163A3E2.2060609@stud.feec.vutbr.cz>
Date: Wed, 06 Oct 2004 09:50:58 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nuno Silva <nuno.silva@vgertech.com>
CC: Patryk Jakubowski <patrics@interia.pl>, linux-kernel@vger.kernel.org
Subject: Re: Invisible threads in 2.6.9
References: <S268296AbUJDTjb/20041004193948Z+2396@vger.kernel.org> <41630B2C.5020709@interia.pl> <4163619C.4070600@vgertech.com>
In-Reply-To: <4163619C.4070600@vgertech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0002]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva wrote:
> Yes, that's the new method trojans are using to hide tasks... No need to 
> install complicated kernel modules anymore :-)
> 
> More seriously: That's a problem with current procps utils... They just 
> don't show them. I can't complain too much because I'm not doing any 
> code, but it would be nice to have a working top...
> 
> As a workaround, to at least see the threads without inspecting /proc 
> directly, you can use the 'm' and 'H' flags to ps, i.e.
> 
> $ ps auwxH
> 

It doesn't work for me:

# ps aux | grep [t]hread
michich   7447  0.0  0.0     0    0 pts/1    Zl+  09:43   0:00 [threadbug] <defunct>
# ps auwxH | grep [t]hread
#

And I can't inspect /proc directly:
# cd /proc/7447
# ls -l
ls: cannot read symbolic link cwd: No such file or directory
ls: cannot read symbolic link root: No such file or directory
ls: cannot read symbolic link exe: No such file or directory
total 0
dr-xr-xr-x  2 root root 0 Oct  6 09:48 attr
-r--------  1 root root 0 Oct  6 09:48 auxv
-r--r--r--  1 root root 0 Oct  6 09:44 cmdline
lrwxrwxrwx  1 root root 0 Oct  6 09:48 cwd
-r--------  1 root root 0 Oct  6 09:48 environ
lrwxrwxrwx  1 root root 0 Oct  6 09:48 exe
dr-x------  2 root root 0 Oct  6 09:44 fd
-r--r--r--  1 root root 0 Oct  6 09:48 maps
-rw-------  1 root root 0 Oct  6 09:48 mem
-r--r--r--  1 root root 0 Oct  6 09:48 mounts
lrwxrwxrwx  1 root root 0 Oct  6 09:48 root
-r--r--r--  1 root root 0 Oct  6 09:44 stat
-r--r--r--  1 root root 0 Oct  6 09:48 statm
-r--r--r--  1 root root 0 Oct  6 09:44 status
dr-xr-xr-x  3 root root 0 Oct  6 09:45 task
-r--r--r--  1 root root 0 Oct  6 09:48 wchan
# cd task
bash: cd: task: No such file or directory
# ls -l task
ls: task: No such file or directory
# ls -l | grep task
ls: cannot read symbolic link cwd: No such file or directory
ls: cannot read symbolic link root: No such file or directory
ls: cannot read symbolic link exe: No such file or directory
dr-xr-xr-x  3 root root 0 Oct  6 09:45 task

Isn't it strange?

Michal Schmidt
