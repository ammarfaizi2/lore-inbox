Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286249AbRLJN5s>; Mon, 10 Dec 2001 08:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLJN5i>; Mon, 10 Dec 2001 08:57:38 -0500
Received: from [160.131.145.246] ([160.131.145.246]:4613 "EHLO W20303512")
	by vger.kernel.org with ESMTP id <S286249AbRLJN52>;
	Mon, 10 Dec 2001 08:57:28 -0500
Message-ID: <00df01c18182$63f1ff20$f69183a0@W20303512>
From: "Wilson" <defiler@null.net>
To: "Robert Love" <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Cc: <kpreempt-tech@lists.sourceforge.net>
In-Reply-To: <1007930466.11789.2.camel@phantasy> <01121008545000.01013@manta> <1007967834.878.30.camel@phantasy>
Subject: Re: [PATCH] fully preemptible kernel
Date: Mon, 10 Dec 2001 08:55:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Robert Love" <rml@tech9.net>
To: "vda" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>; <kpreempt-tech@lists.sourceforge.net>
Sent: Monday, December 10, 2001 2:03 AM
Subject: Re: [PATCH] fully preemptible kernel


> On Mon, 2001-12-10 at 05:54, vda wrote:
>
> > I reported a problem with preemptible 2.4.13 and Samba server (oops,
problems
> > with creation of files from win clients).
> > Is this issue addressed?
>
> No, because I could not reproduce it.  Could you see if it occurs on the
> current kernel with the current patch?  If so, send me the relevant
> information.
>
> Robert Love
>

I saw this as well, with 2.4.12-ac3+preempt and Samba 2.2.2.
Errors like this:
  ===============================================================
[2001/10/21 18:53:24, 0] lib/util.c:smb_panic(1055)
  PANIC: internal error
[2001/10/21 18:55:56, 0] smbd/nttrans.c:call_nt_transact_ioctl(1762)
  call_nt_transact_ioctl: Currently not implemented.
[2001/10/21 21:16:05, 0] lib/fault.c:fault_report(40)
  ===============================================================
[2001/10/21 21:16:05, 0] lib/fault.c:fault_report(41)
  INTERNAL ERROR: Signal 11 in pid 7540 (2.2.2)
  Please read the file BUGS.txt in the distribution
[2001/10/21 21:16:05, 0] lib/fault.c:fault_report(43)
  ===============================================================

I'll recompile 2.4.16 with the new preempt patch, and see if this problem
has gone away.



