Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbRERRGI>; Fri, 18 May 2001 13:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261176AbRERRF6>; Fri, 18 May 2001 13:05:58 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:43401 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261172AbRERRFq>; Fri, 18 May 2001 13:05:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: APIC, AMD-K6/2 -mcpu=586...
In-Reply-To: <m2u22ibww6.fsf@sympatico.ca>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 18 May 2001 13:04:09 -0400
In-Reply-To: Bill Pringlemeir's message of "18 May 2001 09:38:01 -0400"
Message-ID: <m2d796twqe.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "WJP" == Bill Pringlemeir <bpringle@sympatico.ca> writes:
[snip]
 WJP> I have the 2.4.4 distribution from kernel.org.

 WJP>  "http://www.kernel.org/pub/linux/kernel/v2.4/"

 WJP> I have a Mandrake system and selected the AMD processors and
 WJP> APIC option.  The egcs-2.91.66 compiler with -mcpu=586.  It
 WJP> appears that the structure alignment of the floating point

Sorry,

I compiled from a user account and `/usr/bin' was before
`/usr/local/bin' on my path.  I had actually installed the tools as
per Documentation/Changes, honest! I was compiling with the
pgcc-2.91.66 and not egcs-2.91.66.  The root account was set up to use
egcs-2.91.66.

Why don't the build scripts run a dummy file to determine where the 
floating point registers should be placed?

...
const int value = offsetof(struct task_struct, thread.i387.fxsave) & 15;
...

VAL = objdump --all-headers foo.o | grep value | cut -c 48-57
PAD_SIZE = objdump --start-address=$VAL --disassemble-all foo.o | cut...

Or perhaps some better method for determining the offset on the host,

Compiling and execute won't work in cross development mode...

int main(){return offsetof(struct task_struct, thread.i387.fxsave) & 15;}

Perhaps this is a bit much to demand, instead of having a specific
compiler.

fwiw,
Bill Pringlemeir.



