Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263007AbTCWKUo>; Sun, 23 Mar 2003 05:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263008AbTCWKUo>; Sun, 23 Mar 2003 05:20:44 -0500
Received: from lapd.cj.edu.ro ([193.231.142.101]:2979 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id <S263007AbTCWKUn>;
	Sun, 23 Mar 2003 05:20:43 -0500
Date: Sun, 23 Mar 2003 12:31:39 +0200 (EET)
From: "Lists (lst)" <linux@lapd.cj.edu.ro>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
In-Reply-To: <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.51L0.0303231225070.15290@lapd.cj.edu.ro>
References: <20030322103121.A16994@flint.arm.linux.org.uk>
 <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-406755954-1789754545-1048415499=:15290"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---406755954-1789754545-1048415499=:15290
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 22 Mar 2003, Alan Cox wrote:

> On Sat, 2003-03-22 at 10:31, Russell King wrote:
> > Are the authors of the ptrace patch aware that, in addition to closing the
> > hole, the "fix" also prevents a ptrace-capable task (eg, strace started by
> > root) from ptracing user threads?
> 
> Its an unintended side effect, nobody has sent a patch to fix it yet.

Hi,

mlafon send a patch to the list:
--------------------------------------------------------------------
Date: Wed, 19 Mar 2003 12:28:02 +0100
From: mlafon@arkoon.net
To: linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25

The patch breaks /proc/<pid>/cmdline and /proc/<pid>/environ for 'non 
dumpable'
processes, even for root.

We need to access theses proc files for processes monitoring.

Included is a patch to restore this functionnality for root.

Any comments ?
(See attached file: cmdline_environ_fix.diff)
--------------------------------------------------------------------

Nobody responded to his e-mail. I attach the patch again. I will test 
the patch tomorow.


Cosmin
---406755954-1789754545-1048415499=:15290
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cmdline_environ_fix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51L0.0303231231390.15290@lapd.cj.edu.ro>
Content-Description: 
Content-Disposition: attachment; filename="cmdline_environ_fix.diff"

ZGlmZiAtdSAtcjEuMy4yNC4xIHB0cmFjZS5jDQotLS0gbGludXgtMi40L2tl
cm5lbC9wdHJhY2UuYwkyMDAzLzAzLzE5IDEwOjUwOjU3CTEuMy4yNC4xDQor
KysgbGludXgtMi40L2tlcm5lbC9wdHJhY2UuYwkyMDAzLzAzLzE5IDEwOjU0
OjQ1DQpAQCAtMTQwLDcgKzE0MCw3IEBADQogCS8qIFdvcnJ5IGFib3V0IHJh
Y2VzIHdpdGggZXhpdCgpICovDQogCXRhc2tfbG9jayh0c2spOw0KIAltbSA9
IHRzay0+bW07DQotCWlmICghaXNfZHVtcGFibGUodHNrKSB8fCAoJmluaXRf
bW0gPT0gbW0pKQ0KKwlpZiAoKCFpc19kdW1wYWJsZSh0c2spIHx8ICgmaW5p
dF9tbSA9PSBtbSkpICYmIChjdXJyZW50LT51aWQgIT0gMCkpDQogCQltbSA9
IE5VTEw7DQogCWlmIChtbSkNCiAJCWF0b21pY19pbmMoJm1tLT5tbV91c2Vy
cyk7DQo=

---406755954-1789754545-1048415499=:15290--
