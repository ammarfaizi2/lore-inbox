Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbQKJQXU>; Fri, 10 Nov 2000 11:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130615AbQKJQXK>; Fri, 10 Nov 2000 11:23:10 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:22900 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129608AbQKJQXE>; Fri, 10 Nov 2000 11:23:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14860.8449.485106.841805@somanetworks.com>
Date: Fri, 10 Nov 2000 11:23:29 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: "Corisen" <csyap@starnet.gov.sg>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: compiling 2.4.0-test10 kernel
In-Reply-To: <001101c04b0b$53cc5f40$050010ac@starnet.gov.sg>
In-Reply-To: <20001110112146.12035.qmail@web1103.mail.yahoo.com>
	<001101c04b0b$53cc5f40$050010ac@starnet.gov.sg>
X-Mailer: VM 6.75 under 21.2  (beta35) "Nike" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "C" == Corisen  <csyap@starnet.gov.sg> writes:

 C> hi, i'm currently running RH7, with 2.2.16-22 kernel, gcc 2.96 on
 C> a Sharp Actius 250 notebook.

 C> i've manged to successfully compile 2.4.0-test10 kernel. however,
 C> upon startup there are some failed/error messages:
 C> 1. finding module dependencies: depmod *** Unresolved symbols in
 C> /lib/modules/2.4.0-test10/kernel/arch/i386/kernel/apm.o

There are two things you can do about this:

 1. Disable module versioning.
 2. Copy the System.map file that's made during the kernel build to
    /boot/System.map-2.4.0-test10.

Personally, I do 2.  Though, now I'm attempting to get the maestro
driver working again and this is getting in my way.  So my question to
those that know more is what is the correct way to build a module such
that it'll insmod in the face of module versioning.  Is this something
for the FAQ?

 C> 2. Starting NFS lockd: lockdsvc: Invalid argument [FAILED]

I've been ignoring this (I'm sure at my peril).

 C> during shutdown, the following failed messages was noticed:
 C> 1. Turning off accounting: aacton: Function not implemented

You can try enabling BSD process accounting in your configuration.  I
have not and also get this message (and don't care).

 C> 2. Shutting down NFS lockd [FAILED]

As above.

 C> the system is also not able to shutdown/power off completely after
 C> "shutdown -h now". however, using RH7 2.2.16 kernel, the notebook
 C> was able to power off. how can i configure it to turn off
 C> automatically?

My laptop (a Fujitsu E6520 stop powering off with RH7 regardless of
whether I used the supplied kernel or the test10 that I built), so
consider yourself lucky ;-)

Also, the default compiler on RH7 is not correct.  Use kgcc instead
(ie. make CC=kgcc bzImage).  The gcc2.96 is said/known not to work for
kernel work.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
