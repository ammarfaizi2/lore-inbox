Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWEKOvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWEKOvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 10:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWEKOvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 10:51:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751815AbWEKOvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 10:51:43 -0400
Message-ID: <44634F63.1090504@redhat.com>
Date: Thu, 11 May 2006 09:51:15 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Robert Crocombe <rwcrocombe@raytheon.com>
CC: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rtXYZ hangs at boot on quad Opteron
References: <44623EE0.8040300@raytheon.com> <Pine.LNX.4.58.0605101540490.22959@gandalf.stny.rr.com> <44628A70.1020502@raytheon.com>
In-Reply-To: <44628A70.1020502@raytheon.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robert Crocombe wrote:
> testing NMI watchdog ... OK.
>
> where we croak.  On the non-realtime version, it is instead like so:

Yeah, this is where my Athlon64x2 goes into the weeds.  I followed it
down into the routines that calculate processor migration costs and
got lost in the context switches.  I suspect that the forced
migrations aggravate a problem down in the 64-bit arch specific code
that hasn't been looked at in a while (I believe most people running
AMD are doing so in 32-bit mode).

Maybe it's time for round two...

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEY09jHyuj/+TTEp0RAl2OAKDYxUa4mW8mvw3cu4QPUvvhpbT+SQCeOq2L
gagGErHh8V89Yd2Z76hDfuk=
=rUnG
-----END PGP SIGNATURE-----

