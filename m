Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbSK2XAu>; Fri, 29 Nov 2002 18:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbSK2XAt>; Fri, 29 Nov 2002 18:00:49 -0500
Received: from komoseva.globalnet.hr ([213.149.32.250]:1554 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id <S267174AbSK2XAs>; Fri, 29 Nov 2002 18:00:48 -0500
Date: Sat, 30 Nov 2002 00:07:46 +0100
From: Vid Strpic <vms@bofhlet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel link error
Message-ID: <20021130000746.G1861@localhost>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <no.id>; from ramune@net-ronin.org on Fri, Nov 29, 2002 at 07:00:50AM -0800
X-Operating-System: Linux 2.4.19
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled May  3 2002 20:49:56)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 07:00:50AM -0800, carbonated beverage wrote:
> Anything other info needed?
> gcc 2.95.4
> binutils 2.12.90.0.1
> Debian/woody
> Linux 2.4.20

Same config, but gcc 3.2.1 :


In file included from /usr/src/linux-2.4.20/include/linux/wait.h:13,
                 from /usr/src/linux-2.4.20/include/linux/fs.h:12,
                 from /usr/src/linux-2.4.20/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.20/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.20/include/linux/sched.h:9,
                 from buffer.c:32:
/usr/src/linux-2.4.20/include/linux/kernel.h:10:20: stdarg.h: No such file or directory


... and this repeats all over `make dep`... and when I'm making bzImage:


/usr/src/linux-2.4.20/include/linux/kernel.h:74: parse error before "va_list"
/usr/src/linux-2.4.20/include/linux/kernel.h:74: warning: function declaration isn't a prototype
/usr/src/linux-2.4.20/include/linux/kernel.h:77: parse error before "va_list"
/usr/src/linux-2.4.20/include/linux/kernel.h:77: warning: function declaration isn't a prototype
/usr/src/linux-2.4.20/include/linux/kernel.h:81: parse error before "va_list"
/usr/src/linux-2.4.20/include/linux/kernel.h:81: warning: function declaration isn't a prototype
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.20/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/kernel'
make: *** [_dir_kernel] Error 2


It is the same with gcc-2.95.4 (from Debian package), btw ... I tried
rml patch (for rc4), and it also shows the same behavior....


-- 
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux lorien 2.4.19 #1 Mon Sep 16 09:01:48 CEST 2002 i586
 23:58:05 up 2 days,  7:41, 29 users,  load average: 3.27, 3.27, 2.94
Prije nego sto ukljucis komp ubaci uticnicu u utikac. (DMC)
