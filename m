Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVJHWYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVJHWYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVJHWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:24:46 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:3173 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932178AbVJHWYq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:24:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NYWFyXmM9soEPJ6dsIUc/HCV6odfDNWojNYNdNakRZVQPTb2+pXGBa2TndvbuRxrLGJYLMgUWS2tcAcFOvA2k28hLyjRcxn0In0tIjWz80t8cAKgfs5TQ2A6w5gprPzM1KccOXit+SZJNbQgvKRZ44yxPWvYmnJhqdb0lZ3jTwk=
Message-ID: <5bdc1c8b0510081524g56a328f9ubad8a73bf6cd60d@mail.gmail.com>
Date: Sat, 8 Oct 2005 15:24:43 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc3-rt13 build problem (Invoked `ld.so')
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I've been quietly working here on my xrun issues. They are getting
better with every kernel. I'm down to just a few a day now. However I
am pretty reliably able to create at least one the first time I start
up Firefox and browse the web. For this reason I thought I'd try
learning to get some latency traces.

1) I built 2.6.14-rc3-rt13. It ran fine.

2) I built 2.6.14-rc3-rt13 with 'Debug Preemptible kernel' enabled. I
get a message boot time warning me that the option is on, but the
kernel boots and runs fine.

3) I then tried to 2.6.14-rc3-rt13 again as above but I added
'Non-preemptible critical section latency timing'. The compile failed.
This is what's in my terminal:

  CC      drivers/acpi/utilities/utobject.o
  CC      drivers/acpi/utilities/utstate.o
  CC      drivers/acpi/utilities/utmutex.o
  CC      drivers/acpi/utilities/utcache.o
Usage: ld.so [OPTION]... EXECUTABLE-FILE [ARGS-FOR-PROGRAM...]
You have invoked `ld.so', the helper program for shared library executables.
This program usually lives in the file `/lib/ld.so', and special directives
in executable files using ELF shared libraries tell the system's program
loader to load the helper program from this file.  This helper program loads
the shared libraries needed by the program executable, prepares the program
to run, and runs it.  You may invoke this helper program directly from the
command line to load and run an ELF executable file; this is like executing
that file itself, but always uses this helper program from the file you
specified, instead of the helper program file specified in the executable
file you run.  This is mostly of use for maintainers to test new versions
of this helper program; chances are you did not intend to run this program.

  --list                list all dependencies and how they are resolved
  --verify              verify that given object really is a dynamically linked
                        object we can handle
  --library-path PATH   use given PATH instead of content of the environment
                        variable LD_LIBRARY_PATH
  --inhibit-rpath LIST  ignore RUNPATH and RPATH information in object names
                        in LIST
make[3]: *** [drivers/acpi/utilities/utcache.o] Error 2
make[2]: *** [drivers/acpi/utilities] Error 2
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2
lightning linux #

   Let me know how to proceed.

Thanks,
Mark
