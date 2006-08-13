Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWHMJ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWHMJ4b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 05:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWHMJ4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 05:56:31 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:62854 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1750880AbWHMJ4b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 05:56:31 -0400
From: Gerhard =?iso-8859-1?q?Gau=DFling?= <ggrubbish@web.de>
Reply-To: ggrubbish@web.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.8-rt8: Compile Error in misdn/avm_fritz.c - error: syntax error before string constant
Date: Sun, 13 Aug 2006 12:00:07 +0200
User-Agent: KMail/1.9.1
References: <200608130439.42751.ggrubbish@web.de>
In-Reply-To: <200608130439.42751.ggrubbish@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608131200.09660.ggrubbish@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 13. August 2006 04:39 schrieb Gerhard Gauﬂling:
> I followed mainly this howto
> http://ubuntustudio.com/wiki/index.php/Dapper:Vanilla_Kernel_With_Rea
>ltime_Preemption
>
> But I ran into problems with the needed rt patch of Ingo Molnar:
> http://people.redhat.com/mingo/realtime-preempt/patch-2.6.17-rt8
>
> It failed on the 2.6.17.8 in 1 chunk on the Makefile and 1 chunk of
> kernel/sched.c .
>[...]
> make[4]: Entering directory `/usr/src/linux-2.6.17-rt8'
>   CC [M]  /usr/src/modules/realtime-lsm/realcap.o
> /usr/src/modules/realtime-lsm/realcap.c:1: warning:
> -ffunction-sections disabled; it makes profiling impossible
> /usr/src/modules/realtime-lsm/realcap.c:36: error: syntax error
> before string constant
> /usr/src/modules/realtime-lsm/realcap.c:36: warning: type defaults
> to 'int' in declaration of 'MODULE_PARM'
> /usr/src/modules/realtime-lsm/realcap.c:36: warning: function
> declaration isn't a prototype
> /usr/src/modules/realtime-lsm/realcap.c:36: warning: data definition
> has no type or storage class
> /usr/src/modules/realtime-lsm/realcap.c:40: error: syntax error
> before string constant
>[...]
> make[1]: *** [kdist_build] Error 2
> make[1]: Leaving directory `/usr/src/modules/realtime-lsm'
> Module /usr/src/modules/realtime-lsm failed.
> Hit return to Continue
> [...]
> make[1]: Entering directory `/usr/src/modules/misdn'
> /usr/bin/make -w -f debian/rules  binary-modules
> make[2]: Entering directory `/usr/src/modules/misdn'
> sed -e 's/@@Kernel\-Version@@/2.6.17.8-rt8.8-rt8/' \
>             debian/control.in > debian/control
> dh_testdir
> dh_testroot
> dh_clean -k
> dh_clean: Compatibility levels before 4 are deprecated.
> echo "kpkg:Kernel-Version=2.6.17.8-rt8.8-rt8" > \
>             debian/misdn-kernel-modules-2.6.17.8-rt8.8-rt8.substvars
> /usr/bin/make -C /usr/src/linux M=/usr/src/modules/misdn   modules
> make[3]: Entering directory `/usr/src/linux-2.6.17-rt8'
>   CC [M]  /usr/src/modules/misdn/avm_fritz.o
> /usr/src/modules/misdn/avm_fritz.c:1: warning: -ffunction-sections
> disabled; it makes profiling impossible
> In file included from /usr/src/modules/misdn/avm_fritz.c:24:
> /usr/src/modules/misdn/helper.h: In function 'alloc_stack_skb':
> /usr/src/modules/misdn/helper.h:60: warning: format '%d' expects
> type 'int', but argument 3 has type 'size_t'
> /usr/src/modules/misdn/helper.h:60: warning: format '%d' expects
> type 'int', but argument 4 has type 'size_t'
> /usr/src/modules/misdn/avm_fritz.c: At top level:
> /usr/src/modules/misdn/avm_fritz.c:1013: error: syntax error before
> string constant
> /usr/src/modules/misdn/avm_fritz.c:1013: warning: type defaults to
> 'int' in declaration of 'MODULE_PARM'
> /usr/src/modules/misdn/avm_fritz.c:1013: warning: function
> declaration isn't a prototype
> /usr/src/modules/misdn/avm_fritz.c:1013: warning: data definition has
> no type or storage class
> /usr/src/modules/misdn/avm_fritz.c:1014: error: syntax error before
> string constant
> /usr/src/modules/misdn/avm_fritz.c:1014: warning: type defaults to
> 'int' in declaration of 'MODULE_PARM'
> /usr/src/modules/misdn/avm_fritz.c:1014: warning: function
> declaration isn't a prototype
> /usr/src/modules/misdn/avm_fritz.c:1014: warning: data definition has
> no type or storage class
> /usr/src/modules/misdn/avm_fritz.c:1015: error: syntax error before
> string constant
> /usr/src/modules/misdn/avm_fritz.c:1015: warning: type defaults to
> 'int' in declaration of 'MODULE_PARM'
> /usr/src/modules/misdn/avm_fritz.c:1015: warning: function
> declaration isn't a prototype
> /usr/src/modules/misdn/avm_fritz.c:1015: warning: data definition has
> no type or storage class
> make[4]: *** [/usr/src/modules/misdn/avm_fritz.o] Error 1
> make[3]: *** [_module_/usr/src/modules/misdn] Error 2
> make[3]: Leaving directory `/usr/src/linux-2.6.17-rt8'
> make[2]: *** [binary-modules] Error 2
> make[2]: Leaving directory `/usr/src/modules/misdn'
> make[1]: *** [kdist_image] Error 2
> make[1]: Leaving directory `/usr/src/modules/misdn'
> Module /usr/src/modules/misdn failed.
> Hit return to Continue
>
> =================
> =================
>
> I got in almost every line this warning:
> warning: -ffunction-sections disabled; it makes profiling impossible
>
> I think that does not affect the kernel ?
>
> Can someone help me to get the realtime-lsm compiled on the new
> 2.6.17.8 kernel, please?

I'm Sorry for answering to myself, but I want to add this:

I'm running on 
Linux ubuntu 2.6.15-26-amd64-generic #1 SMP PREEMPT Thu Aug 3 02:52:35 
UTC 2006 x86_64 GNU/Linux

and I figured out, that the realtime-lsm is deprecated now:
"If you want to use the *deprecated* Realtime LSM, then you can prepare 
to make a deb package for it during this process as well"
http://ubuntustudio.com/wiki/index.php/Breezy:Enabling_Preemption
http://ubuntustudio.com/wiki/index.php/Breezy:Realtime_LSM

Therefore only the avm_fritz.c is of any interest I think.

I'm Sorry for the noise, I hope this is the appropriate ML for that 
error ??

Kind regards

Gerhard Gauﬂling
