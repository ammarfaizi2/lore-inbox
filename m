Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbQKJAO4>; Thu, 9 Nov 2000 19:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbQKJAOr>; Thu, 9 Nov 2000 19:14:47 -0500
Received: from agrashak.cpg.com.au ([138.79.128.10]:51717 "HELO
	agrashak.cpg.com.au") by vger.kernel.org with SMTP
	id <S129562AbQKJAOf>; Thu, 9 Nov 2000 19:14:35 -0500
Message-ID: <3A0B3E17.9D7E3FFA@cpgen.cpg.com.au>
Date: Fri, 10 Nov 2000 11:15:19 +1100
From: Grahame Jordan <jordg@cpgen.cpg.com.au>
Organization: Interim Technology Training Institute
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS, Can't get request slot
In-Reply-To: <E13p7sA-0004M5-00@the-village.bc.nu>
Content-Type: multipart/alternative;
 boundary="------------FF7A9F2F6A0B5EA69C61B446"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------FF7A9F2F6A0B5EA69C61B446
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan,

On a client running all by itself on our production network overnight, doing an
"ls -lR /usr" and doing a compile (in a loop) is giving the same problems.

A little snipit from /var/log/messages
Nov 10 04:31:20 spc81 kernel: nfs: server student OK
Nov 10 04:33:17 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:33:17 spc81 kernel: nfs: server student OK
Nov 10 04:34:59 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:35:04 spc81 kernel: nfs: task 20823 can't get a request slot
Nov 10 04:35:35 spc81 kernel: nfs: server student OK
Nov 10 04:35:35 spc81 kernel: nfs: server student OK
Nov 10 04:44:43 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:44:44 spc81 kernel: nfs: server student OK
Nov 10 04:45:56 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:46:00 spc81 kernel: nfs: task 20457 can't get a request slot
Nov 10 04:46:00 spc81 kernel: nfs: server student OK
Nov 10 04:46:03 spc81 kernel: nfs: server student OK
Nov 10 04:49:15 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:49:15 spc81 kernel: nfs: server student OK
Nov 10 04:49:25 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:52:21 spc81 kernel: nfs: server student OK
Nov 10 04:53:43 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:53:43 spc81 kernel: nfs: server student OK
Nov 10 04:54:01 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:54:02 spc81 kernel: nfs: task 64822 can't get a request slot
Nov 10 04:54:13 spc81 kernel: nfs: server student OK
Nov 10 04:54:15 spc81 kernel: nfs: server student OK
Nov 10 04:55:57 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:55:59 spc81 kernel: nfs: task 29484 can't get a request slot
Nov 10 04:56:21 spc81 kernel: nfs: server student OK
Nov 10 04:56:23 spc81 kernel: nfs: server student OK
Nov 10 04:58:15 spc81 kernel: nfs: server student not responding, still trying
Nov 10 04:58:21 spc81 kernel: nfs: task 1477 can't get a request slot
Nov 10 04:58:52 spc81 kernel: nfs: task 1478 can't get a request slot
Nov 10 04:59:15 spc81 kernel: nfs: server student OK

Shows that under no (or little) load this thing is failing.

We have 20 networks with ~100 machines on each with this same problem.  Only a
few at a time are using Linux.  We are trying to promote Linux as a great
operating system, but this is not helping.  Again the samba on win95 is puring
along nicely plus every other service but for NFS.

We have changed the NIC on this server to 3Com 3c90x for no change in status.
Clients are using  CNETPro120 200 and Intel eepro100

The servers are generally PIII500  512MB RAM.

We have tried mount flags rsize=1024, 8192, 128, with no change.

It looks like a server issue related to RPC.   But I am only guessing here.

Any more help is much appreciated.

Thanks

Grahame Jordan


Alan Cox wrote:

> > By the evidence that we have gathered it seems that the Server is not
> > taxed too much as samba users are getting files OK etc.  The can't get
> > request slot is plaguing many others in different ways.   It looks like
> > an NFS issue.   How can this be proven?  Then we can work on the
> > problem.
>
> The request queue slot message means the server isnt responding (at least in
> the eyes of the client). Given you can get into the box that isnt the
> net card (at least not now). What mount options do you use ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--
Grahame Jordan
Network Manager
Interim Technology Training Institute
  Mobile: +61 3 0408 058 209
  Phone:  +61 3 9243 2220
  Fax:    +61 3 9820 2010
  e-mail: jordg@cpgen.cpg.com.au
  Transforming the way people work with technology with
  INTEGRITY LEARNING INNOVATION TEAMWORK PERFORMANCE



--------------FF7A9F2F6A0B5EA69C61B446
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Alan,
<p>On a client running all by itself on our production network overnight,
doing an "ls -lR&nbsp;/usr" and doing a compile (in a loop) is giving the
same problems.
<p>A little snipit from /var/log/messages
<br>Nov 10 04:31:20 spc81 kernel: nfs: server student OK
<br>Nov 10 04:33:17 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:33:17 spc81 kernel: nfs: server student OK
<br>Nov 10 04:34:59 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:35:04 spc81 kernel: nfs: task 20823 can't get a request slot
<br>Nov 10 04:35:35 spc81 kernel: nfs: server student OK
<br>Nov 10 04:35:35 spc81 kernel: nfs: server student OK
<br>Nov 10 04:44:43 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:44:44 spc81 kernel: nfs: server student OK
<br>Nov 10 04:45:56 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:46:00 spc81 kernel: nfs: task 20457 can't get a request slot
<br>Nov 10 04:46:00 spc81 kernel: nfs: server student OK
<br>Nov 10 04:46:03 spc81 kernel: nfs: server student OK
<br>Nov 10 04:49:15 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:49:15 spc81 kernel: nfs: server student OK
<br>Nov 10 04:49:25 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:52:21 spc81 kernel: nfs: server student OK
<br>Nov 10 04:53:43 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:53:43 spc81 kernel: nfs: server student OK
<br>Nov 10 04:54:01 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:54:02 spc81 kernel: nfs: task 64822 can't get a request slot
<br>Nov 10 04:54:13 spc81 kernel: nfs: server student OK
<br>Nov 10 04:54:15 spc81 kernel: nfs: server student OK
<br>Nov 10 04:55:57 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:55:59 spc81 kernel: nfs: task 29484 can't get a request slot
<br>Nov 10 04:56:21 spc81 kernel: nfs: server student OK
<br>Nov 10 04:56:23 spc81 kernel: nfs: server student OK
<br>Nov 10 04:58:15 spc81 kernel: nfs: server student not responding, still
trying
<br>Nov 10 04:58:21 spc81 kernel: nfs: task 1477 can't get a request slot
<br>Nov 10 04:58:52 spc81 kernel: nfs: task 1478 can't get a request slot
<br>Nov 10 04:59:15 spc81 kernel: nfs: server student OK
<p>Shows that under no (or little)&nbsp;load this thing is failing.
<p>We have 20 networks with ~100 machines on each with this same problem.&nbsp;
Only a few at a time are using Linux.&nbsp; We are trying to promote Linux
as a great operating system, but this is not helping.&nbsp; Again the samba
on win95 is puring along nicely plus every other service but for NFS.
<p>We have changed the NIC on this server to 3Com 3c90x for no change in
status.&nbsp; Clients are using&nbsp; CNETPro120 200 and Intel eepro100
<p>The servers are generally PIII500&nbsp; 512MB RAM.
<p>We have tried mount flags rsize=1024, 8192, 128, with no change.
<p>It looks like a server issue related to RPC.&nbsp;&nbsp; But I am only
guessing here.
<p>Any more help is much appreciated.
<p>Thanks
<p>Grahame Jordan
<br>&nbsp;
<p>Alan Cox wrote:
<blockquote TYPE=CITE>> By the evidence that we have gathered it seems
that the Server is not
<br>> taxed too much as samba users are getting files OK etc.&nbsp; The
can't get
<br>> request slot is plaguing many others in different ways.&nbsp;&nbsp;
It looks like
<br>> an NFS issue.&nbsp;&nbsp; How can this be proven?&nbsp; Then we can
work on the
<br>> problem.
<p>The request queue slot message means the server isnt responding (at
least in
<br>the eyes of the client). Given you can get into the box that isnt the
<br>net card (at least not now). What mount options do you use ?
<br>-
<br>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
<br>the body of a message to majordomo@vger.kernel.org
<br>Please read the FAQ at <a href="http://www.tux.org/lkml/">http://www.tux.org/lkml/</a></blockquote>

<pre>--&nbsp;
Grahame Jordan
Network Manager
Interim Technology Training Institute
&nbsp; Mobile: +61 3 0408 058 209&nbsp;
&nbsp; Phone:&nbsp; +61 3 9243 2220
&nbsp; Fax:&nbsp;&nbsp;&nbsp; +61 3 9820 2010
&nbsp; e-mail: jordg@cpgen.cpg.com.au
&nbsp; Transforming the way people work with technology with&nbsp;
&nbsp; INTEGRITY LEARNING INNOVATION TEAMWORK PERFORMANCE</pre>
&nbsp;</html>

--------------FF7A9F2F6A0B5EA69C61B446--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
