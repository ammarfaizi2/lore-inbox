Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129866AbQLHWq7>; Fri, 8 Dec 2000 17:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130999AbQLHWqt>; Fri, 8 Dec 2000 17:46:49 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:33288 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129866AbQLHWqf>;
	Fri, 8 Dec 2000 17:46:35 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: georgn@somanetworks.com
cc: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, sct@redhat.com
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: Your message of "Fri, 08 Dec 2000 11:30:06 CDT."
             <14897.3214.38818.625199@somanetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Dec 2000 09:16:01 +1100
Message-ID: <4977.976313761@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000 11:30:06 -0500 (EST), 
"Georg Nikodym" <georgn@somanetworks.com> wrote:
>But since you seem to and while we're doing extreme surgery, why have
>klogd at all?  Every other unix, kernel messages are handled by the
>syslog system.  What problem did klogd solve and does that problem
>still exist today?

klogd maps the kernel messages from <n>text to syslog levels and does
some fiddling with kernel log levels at start up.  It needs to be more
than a simple 'cat'.  When symbol handling was added to klogd, ksymoops
was built into the kernel and very unreliable.  Since then ksymoops has
been moved to a separate package and is now reliable.  Alas oops
handling in sysklogd has not kept up to date and is now the problem
area.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
