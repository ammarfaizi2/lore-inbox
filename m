Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284117AbRLROdS>; Tue, 18 Dec 2001 09:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284122AbRLROdI>; Tue, 18 Dec 2001 09:33:08 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:10407 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284133AbRLROdD>; Tue, 18 Dec 2001 09:33:03 -0500
Message-ID: <3C1F5311.2070407@t-online.de>
Date: Tue, 18 Dec 2001 15:30:41 +0100
From: Hans-Otto.Ahl@t-online.de (Hans-Otto Ahl)
Organization: root
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: bug in 2.5.1
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BCC3441C@difpst1a.dif.dk> <3C1F305C.9030702@t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Otto Ahl wrote:

> Jesper Juhl wrote:
> 
>  >  > Hi chaps, sorry to inform you about a problem in 'ide-floppy' drivers
>  >  > and in the module as well.
>  >
>  > Unless you provide some details on the nature of the problem, your
>  > report will probably just be ignored. If you have really found a problem
>  > you should submit a detailed bugreport - a good start is to fill out the
>  > following bug-report form:
>  >
>  >
>  >          B. APPENDIX B - LINUX KERNEL MAILING LIST BUG REPORT FORM
>  >
>  >
>  >
>  >    Please use the following form to report bugs to the Linux kernel
>  >    mailing list. Having a standardized bug report form makes it easier
>  >    for you not to overlook things, and easier for the developers to find
>  >    just the little tad of information they're really interested in.
>  >
>  >    First run the ver_linux script included at the end of this 
> Appendix or
>  >    at <URL:ftp://ftp.sai.msu.su//sai2/ftp/pub/Linux/ver_linux> It checks
>  >    out the version of some important subsystems.
>  >
>  >    Use that information to fill in all fields of the bug report form, 
> and
>  >    post it to the mailing list with a subject of "ISSUE: <one line
>  >    summary from [1.]>" for easy identification by the developers
>  >     [1.] One line summary of the problem:
>  >     [2.] Full description of the problem/report:
>  >     [3.] Keywords (i.e., modules, networking, kernel):
>  >     [4.] Kernel version (from /proc/version):
>  >     [5.] Output of Oops.. message with symbolic information resolved
>  >            (see Kernel Mailing List FAQ, Section 1.5):
>  >     [6.] A small shell script or example program which triggers the
>  >          problem (if possible)
>  >     [7.] Environment
>  >     [7.1.] Software (add the output of the ver_linux script here)
>  >     [7.2.] Processor information (from /proc/cpuinfo):
>  >     [7.3.] Module information (from /proc/modules):
>  >     [7.4.] SCSI information (from /proc/scsi/scsi):
>  >     [7.5.] Other information that might be relevant to the problem
>  >            (please look in /proc and include all information that you
>  >             think to be relevant):
>  >     [X.] Other notes, patches, fixes, workarounds:
>  >
>  >
>  >
>  > Best regards,
>  > Jesper Juhl
>  > jju@dif.dk
>  >
> 
> OK friends, this report will describe the problem:
> I am running kernel 2.5.0 patched with 2.5.1-pre1 which is running alright.
> I tried to compile the new development kernel 2.5.1 of the 16th Dec.
> 2001 and found out that the compilation was stopped with errors at the
> ide-floppy driver. After I changed the configuration of the kernel in
> that way that I changed ide-floppy to a module and compiled the new
> configuration. Making the modules was stopped by giving the same error
> messages as follows:
> -------------------
> ide-floppy.c:      in function 'idefloppy_end_request'
> ide-floppy.c: 699: warning: comparison between pointer and integer
> 
>                     in function 'idefloppy_queue_pc_head'
>                779: incompatible types in assignment
> 
>                     in function 'idefloppy_create_rw_cmd'
>               1214: warning: comparison between pointer and integer
> 
>                     in function 'idefloppy_do_request'
>               1243: switch quantity not an integer
>               1258: warning: unsigned int format, pointer arg (arg2)
>               1246: warning: unreachable code at beginning of switch
> 
>                              statement
> 
>                     in function 'idefloppy_queue_pc_tail'
>               1276: incompatible types in assignment
> -------------------
> [ide-floppy.o] error1
> [_modsubdir_ide] error2
> [mod_drivers] error2
> 
> make modules was stopped.
> 
> 
> 
> These messages I got. My compiler version is gcc 2.95.3
> I hope You can look after that and fix it.
> Regards, Hans
> 
> 
> 
> 
> 



