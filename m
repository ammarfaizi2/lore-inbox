Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271912AbRHVBn2>; Tue, 21 Aug 2001 21:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271913AbRHVBnI>; Tue, 21 Aug 2001 21:43:08 -0400
Received: from member.michigannet.com ([207.158.188.18]:50954 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S271912AbRHVBmy>; Tue, 21 Aug 2001 21:42:54 -0400
Date: Tue, 21 Aug 2001 21:42:33 -0400
From: Paul <set@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
Message-ID: <20010821214233.F218@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com> <m166bjokre.fsf@frodo.biederman.org> <20010819214322.D1315@squish.home.loc> <m1snenmfe0.fsf@frodo.biederman.org> <20010820211410.B218@squish.home.loc> <m1g0amlzcm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1g0amlzcm.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Tue, Aug 21, 2001 at 12:08:09AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com>, on Tue Aug 21, 2001 [12:08:09 AM] said:
> Paul <set@pobox.com> writes:
> 
> > 	I need to setup a test machine to persue this farther, as
> > locking and fscking my main box is no fun:) Ill try to get that
> > strace...
> 
> O.k.  That rules out all kinds of things.  What is interesting at first
> glance is that a) Every oops has been in an interrupt handler. and
> b) It is never remotely at the same location.
> 
> I'm beginning to suspect there is some kind of hardware problem.  But it
> is very weird.  I wonder if dos 6.2 somehow tickles a bug in the media GX
> processor.  Though my top canidate is probably the lazy state switching
> introduced in 2.4.  I know there were some problems with the ldt that were
> fixed, and there might be another case out there.  But I'm just guessing
> in the dark.
> 
> If you can reproduce this on a second machine that would definentily help.
> 
> Eric

	Dear Eric;

	Oops'd twice on intel pentium 90 box. Same dosemu 1.0.0
binary and config files, 2.4.8-ac7 kernel. Behaviour was same as
my k6 box-- I did not decode oops, as that box didnt have a
serial console, and it didnt seem worth transcribing...
(was unable to oops it running 2.2.18pre21 on p90 box) Here
is the tail end of an strace. (the last bit that made it across
the wire during the telnet session-- I logged with fs mounted
sync, but the end of the log was garbage)

Paul
set@pobox.com


select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
write(3,
"8\1\4\0\n\0\0\4\10\0\0\0\250\0\0\0L\1\5\0\2\0\0\4\n\0\0"..., 76)
= 76
write(3,
"L\"\r\0\2\0\0\4\n\0\0\4\0\0\34\0\332\304\304\304\304\304"...,
592) = 592
--- SIGALRM (Alarm clock) ---
sigreturn()                             = ? (mask now [])
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4 <unfinished ...>
--- SIGALRM (Alarm clock) ---
<... vm86 resumed> )                    = -1 ENOSYS (Function not
implemented)
ioctl(3, FIONREAD, [0])                 = 0
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4) = -1 ENOSYS
(Function not implemented)
--- SIGALRM (Alarm clock) ---
sigreturn()                             = ? (mask now [])
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4) = -1 ENOSYS
(Function not implemented)
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
--- SIGALRM (Alarm clock) ---
sigreturn()                             = ? (mask now [])
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4) = -1 ENOSYS
(Function not implemented)
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
select(10, [9], NULL, NULL, {0, 0})     = ? ERESTARTNOHAND (To be
restarted)
--- SIGALRM (Alarm clock) ---
sigreturn()                             = ? (mask now [])
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)

vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4 <unfinished ...>
--- SIGALRM (Alarm clock) ---
<... vm86 resumed> )                    = -1 ENOSYS (Function not
implemented)
ioctl(3, FIONREAD, [0])                 = 0
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4 <unfinished ...>
--- SIGALRM (Alarm clock) ---
<... vm86 resumed> )                    = -1 ENOSYS (Function not
implemented)
ioctl(3, FIONREAD, [0])                 = 0
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
write(3,
"L\1\5\0\2\0\0\4\n\0\0\4\0\0|\1\263\304\304\3048\304\5\0"...,
552) = 552
--- SIGALRM (Alarm clock) ---
sigreturn()                             = ? (mask now [])
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4) = -1 ENOSYS
(Function not implemented)
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
--- SIGALRM (Alarm clock) ---
sigreturn()                             = ? (mask now [])
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4) = -1 ENOSYS
(Function not implemented)
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
select(10, [9], NULL, NULL, {0, 0})     = 0 (Timeout)
vm86(0x1, 0x811e740, 0xa6, 0xfff8fff1, 0x81d66a4 <unfinished ...>
--- SIGALRM (Alarm clock) ---
<... vm86 resumed> )                    = -1 ENOSYS (Function not
implemented)
ioctl(3, FIONREAD, [0])                 = 0
select(0, [], NULL, NULL, {0, 0})       = 0 (Timeout)
