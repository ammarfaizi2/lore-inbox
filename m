Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSACKvQ>; Thu, 3 Jan 2002 05:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285347AbSACKvG>; Thu, 3 Jan 2002 05:51:06 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:50961 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285338AbSACKuw>;
	Thu, 3 Jan 2002 05:50:52 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15412.14140.652362.747279@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 21:49:32 +1100 (EST)
To: Bernard Dautrevaux <Dautrevaux@microprocess.com>
Cc: "'Tom Rini'" <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>,
        Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: RE: [PATCH] C undefined behavior fix
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Dautrevaux writes:

> OH... are you saying that the Linux kernel is not writtent in ANSI C? AFAICR

No, in fact the kernel isn't written in ANSI C. :)
If nothing else, the fact that it uses a lot of gcc-specific
extensions rules that out.  And it assumes that you can freely cast
pointers to unsigned longs and back again.  I'm sure others can add to
this list.

> the standard *requires* that the standard library functions have their
> standard meaning. So if the Linux kernel expects them to have some special
> meaning it is *non-conforming* and then you need a *special* compiler,
> understanding this.

Sure the kernel is non-conforming.  "Conforming" means that the
program will run the same on any architecture, and the Linux kernel
surely won't do that - it won't get very far on a PDP-10, I can assure
you. :)

Paul.
