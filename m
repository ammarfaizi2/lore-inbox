Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVBDMNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVBDMNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVBDMNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:13:44 -0500
Received: from smtp.uk.colt.net ([195.110.64.125]:38288 "EHLO smtp.uk.colt.net")
	by vger.kernel.org with ESMTP id S261169AbVBDMNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:13:34 -0500
From: David Goodenough <david.goodenough@btconnect.com>
Organization: D.G.A. ltd
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
Date: Fri, 4 Feb 2005 12:11:49 +0000
User-Agent: KMail/1.7.1
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <200502041126.14386.oliver@neukum.org> <42035D5A.2030703@gmx.net>
In-Reply-To: <42035D5A.2030703@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041211.49789.david.goodenough@btconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 11:32, Carl-Daniel Hailfinger wrote:
> Oliver Neukum schrieb:
> > Am Freitag, 4. Februar 2005 08:48 schrieb Pavel Machek:
> >>What about simply blocking all video accesses before disk (etc) is
> >>resumed, so that "normal" (not locked in memory) application can be
> >>used?
> >
> > Very bad for debugging. Genuine serial ports are becoming rarer.
>
> As a bonus, even genuine serial ports may be in undefined state after
> resume. I'm unfortunate enough to have a brand new notebook with
> serial port, but the serial console code will print garbage after
> resume until I do a
> echo foo >/dev/ttyS0
>
> I've already sent mail to linux-serial for that problem, but the
> list appears to be dead. Any pointers to the right contact would
> be appreciated.
>
> Regards,
> Carl-Daniel

I wonder if this is related to a problem I have noted on some embedded
systems which only have a serial console (no video, and nothing to do with
ACPI).

If I set up the video console (through LILO), and talk to it using minicom
when the machine starts I am first talking to BIOS, that works fine, then to
LILO which also works, then the kernel starts and that works up to the point
where the proper serial console is loaded, when it picks some bizaar baud rate
and only corrects it when setserial is run.

I have recently noticed this on an SC1100 board, but it is not SC1100 specific
as another manufacturers SC1100 based board does not exhibit this behaviour.

Just a thought and probably no help in getting it solved.  Sorry I do not have
any good contacts, although once when I had a problem with serial ports being
misdetected on an IBM MCA machine Alan Cox fixed it for me so he obviously
knows his way around the code and might be able to fix it for us.

David
