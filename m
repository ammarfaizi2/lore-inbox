Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSBDKEw>; Mon, 4 Feb 2002 05:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288845AbSBDKEm>; Mon, 4 Feb 2002 05:04:42 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:5618 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S288830AbSBDKEc>; Mon, 4 Feb 2002 05:04:32 -0500
Message-ID: <436282DBEE7CD51191E30002A50A636924113B@hasmsx102.iil.intel.com>
From: "Vlodavsky, Zvi" <zvi.vlodavsky@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'kaos@ocs.com.au'" <kaos@ocs.com.au>
Cc: "Vlodavsky, Zvi" <zvi.vlodavsky@intel.com>
Subject: Using "query_module"
Date: Mon, 4 Feb 2002 12:04:19 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please personally CC me with responses on this posting:

I would like to use the "query_module" system call with the QM_SYMBOLS flag
in an application, but I am not sure of what the appropriate way of doing it
is, and whether it is safe.

I have the man-page for query_module on the system on which I am compiling,
but I can't find the function prototype in <linux/module.h>. So, I just
wrote the prototype in my code. Is this the way this should be done?

Other than that, the man page states that struct module_symbol looks like
this:
  		struct module_symbol
            {
            	unsigned long value;
                	unsigned long name;
            };

But in module.h it is defined as:
		struct module_symbol
		{
        		unsigned long value;
        		const char *name;
		};

>From my understanding, the second definition is the way the kernel uses this
struct, and the first definition is the way the user should interpret the
result of query_module with the QM_SYMBOLS flag. Am I right? (Shouldn't
there be 2 different structures for this?)

Most importantly, I would like to understand whether it is safe to use this
system call. If I compile my application on a machine in which this function
is implemented (in libc), is the system call guaranteed to work on kernels
2.2 and up? Do I need to do a preliminary check such as "if
(query_module(NULL, 0, NULL, 0, NULL))" for the existence of the system
call, or would it simply fail if I use it regularly?

Thanks for your help,
Zvi.

---------------
Zvi Vlodavsky
Software Engineer
Network Communications Group, Intel Corp.
Zvi.Vlodavsky@intel.com

Disclaimer: In this e-mail, I do not speak on behalf of Intel corp.
