Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154769AbPKCKQ1>; Wed, 3 Nov 1999 05:16:27 -0500
Received: by vger.rutgers.edu id <S154487AbPKCKLR>; Wed, 3 Nov 1999 05:11:17 -0500
Received: from smarty.smart.net ([207.176.80.102]:3783 "EHLO smarty.smart.net") by vger.rutgers.edu with ESMTP id <S154797AbPKCJ4u>; Wed, 3 Nov 1999 04:56:50 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <199911030956.EAA10751@smarty.smart.net>
Subject: Toward a host-complete Forth for Linux
To: linux-kernel@vger.rutgers.edu
Date: Wed, 3 Nov 1999 04:56:48 -0500 (EST)
Cc: cl@ncdm.com, eddie@mngovsci.com
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu


We all know what Turing-complete is. Turing-complete is just the CPU 
though. What about ports, devices, user feedback? Let's call that
"host-complete". For host-completeness on Linux you have to support at
least the essential syscalls. I believe there are a few that are
derived, i.e. can be built with others. Well, I got about 105 of them
in pforth, which is descended of my old flame, JForth for the Amiga,
via 3DO. write works, I think geteuid works, but I can't begin to
check all of them. They only add about 16k to the C-compiled pforth
kernel, but they represent most of the functionality of Linux. Really,
it's probably more bugs than non-bugs, but it demonstrates linking
syscalls into an existing Forth.

sysforth.tgz is in   ftp://linux01.gwdg.de/pub/cLIeNUX/interim
right next to libsys.

pforth is pretty lucid code, and it doesn't have many libc dependancies,
so a libc-less build is concievable. Then all that's needed for an 
all-Forth userspace that's a complete OS is gcc rewritten in Forth,
which is Left As An Excercize To The Reader   ;o)

pforth is public domain, and so is this release of "sysforth". Further 
work on this by me will be non-free-ified into my distro, so grab it now
if such things interest you. My understanding is that an author can't
release his right to normal authorship aknowledgement, but all other
rights I have in sysforth are released.

Sorry about the topic skew, but since this creates a useable and 
versatile system at about 200k over the size of the kernel itself 
I think it pertains.

Rick Hohensee
here's an outtake of "words"
FIRST_COLON     ::::system.fth  SYSINFO WAIT4
VM86    VM86OLD IDLE    VHANGUP IOPL    LINKSTAT
FIDSTAT STAT    SYSLOG  SOCKET  PORTACCESS
SETPRIORITY     GETPRIORITY     TRUNCATE
READDIR REBOOT  SWAPOFF SWAPON  USELIB  READLINK
SYMLINK SETGROUPS       SETTIMEOFDAY    GETTIMEOFDAY
GETRESOURCEUSAGE        GETRESOURCELIMIT
SETRESOURCELIMIT        SETREGID        SETREUID
SIGSUSPEND      SIGPENDING      SIGPROCMASK
SIGACTION       SETSID  DEVSTAT PERMSMASK
GETPGID SETPGID IOCTL   EGID    EUID    HANDLER
SETGID  PROCESSTIMES    PIPE    RMDIR   MAKEDIR
RENAME  SIGNAL  NICE    TIMESTAMP       PAUSE
PTRACE  EPOCHSET        UID     SETUID  NEWOWNERL
NEWOWNERF       NEWOWNER        MEMRESIZE
BUFFERSFLUSH    TIMEADJUST      FDATASYNC
DIRENTS FCHDIR  PGID    FSYNC   ITIMER  SETITIMER
FSTATFS FCHMOD  FTRUNCATE       GROUPS  GETPGRP
PPID    DUP2FID TEMPROOT        FCNTL3  ACCT
GID     DUPFID  ACCESS  ALARM   UNMOUNT MOUNT
PID     LSEEK   PERMIT  SPECIAL EPOCH   CHDIR
EXECVE  UNLINK  HARDLINK        CREATEFILE
WAITPID CLOSE   OPEN    WRITE   READ    FORK
FLUSH   ARGSTEST        CLIENUX CTEST1  CTEST0

I haven't done the stack-diagrams yet ;o)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
