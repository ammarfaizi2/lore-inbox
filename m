Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTK1KaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 05:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTK1KaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 05:30:22 -0500
Received: from hera.cwi.nl ([192.16.191.8]:65152 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262041AbTK1KaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 05:30:19 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 28 Nov 2003 11:29:57 +0100 (MET)
Message-Id: <UTC200311281029.hASATvD16681.aeb@smtp.cwi.nl>
To: szepe@pinerecords.com, torvalds@osdl.org
Subject: Re: BUG (non-kernel), can hurt developers.
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       root@chaos.analogic.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe it would be very useful to have this information included
> in the standard Linux signal(2) manpage.

OK. You might have included a patch. I made it say

       The  effects  of this call in a multi-threaded process are
       unspecified.

       The routine handler must be very careful, since processing
       elsewhere  was  interrupted at some arbitrary point. POSIX
       has the concept of "safe function".  If  a  signal  inter­
       rupts  an  unsafe  function,  and  handler calls an unsafe
       function, then the behavior is undefined.  Safe  functions
       are listed explicitly in the various standards.  The POSIX
       1003.1-2003 list is

       _Exit()  _exit()  abort()  accept()  access()  aio_error()
       aio_return()  aio_suspend()  alarm()  bind() cfgetispeed()
       cfgetospeed() cfsetispeed() cfsetospeed() chdir()  chmod()
       chown()  clock_gettime()  close()  connect() creat() dup()
       dup2() execle() execve() fchmod() fchown() fcntl()  fdata­
       sync()  fork()  fpathconf()  fstat()  fsync()  ftruncate()
       getegid()  geteuid()  getgid()  getgroups()  getpeername()
       getpgrp()  getpid()  getppid()  getsockname() getsockopt()
       getuid() kill() link() listen()  lseek()  lstat()  mkdir()
       mkfifo()   open()   pathconf()   pause()   pipe()   poll()
       posix_trace_event() pselect()  raise()  read()  readlink()
       recv()  recvfrom()  recvmsg()  rename()  rmdir()  select()
       sem_post() send() sendmsg()  sendto()  setgid()  setpgid()
       setsid()   setsockopt()  setuid()  shutdown()  sigaction()
       sigaddset() sigdelset() sigemptyset() sigfillset()  sigis­
       member() sleep() signal() sigpause() sigpending() sigproc­
       mask() sigqueue() sigset() sigsuspend()  socket()  socket­
       pair()   stat()  symlink()  sysconf()  tcdrain()  tcflow()
       tcflush()  tcgetattr()  tcgetpgrp()  tcsendbreak()   tcse­
       tattr()  tcsetpgrp()  time() timer_getoverrun() timer_get­
       time() timer_settime() times()  umask()  uname()  unlink()
       utime() wait() waitpid() write().

Andries
