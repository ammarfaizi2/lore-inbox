Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272153AbRHVWvp>; Wed, 22 Aug 2001 18:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272154AbRHVWvf>; Wed, 22 Aug 2001 18:51:35 -0400
Received: from ares.sot.com ([195.74.13.236]:50948 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S272153AbRHVWvW>;
	Wed, 22 Aug 2001 18:51:22 -0400
From: Santeri Kannisto <ss@ares.sot.com>
Message-Id: <200108222251.BAA04797@ares.sot.com>
Subject: Re: 2.4.9: GCC 3.0 problem in "acct.c"
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Date: Thu, 23 Aug 2001 01:51:33 +0300 (EEST)
reply-to: Santeri.Kannisto@sot.com
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> peter k. wrote:
>> i just updated my gcc from 2.96 to 3.0.1 and now i cant compile kernel 2.4.9
>> anymore, make bzImage fails with the following error message:
>> 
>> acct.c: In function `check_free_space':
>> acct.c:147: Unrecognizable insn:
>> (insn 335 102 336 (parallel[
>>             (set (reg/v:SI 2 ecx [44])
>>                 (const_int 0 [0x0]))
>>             (clobber (reg:CC 17 flags))
>>         ] ) -1 (insn_list:REG_DEP_ANTI 100 (insn_list:REG_DEP_ANTI 102
>> (nil)))
>>     (expr_list:REG_UNUSED (reg:CC 17 flags)
>>         (nil)))
>> acct.c:147: Internal compiler error in insn_default_length, at
>> insn-attrtab.c:223
>> 
>> can anyone tell me how to fix this?
>
> Use gcc 2.96 or gcc 3.0.0. You broke the compiler. Please also see the gcc bug
> reporting instructions. You will actually make a gcc hacker very happy 
> reporting that problem.

Except that a similar problem with capi existed allready with gcc 3.0 +
kernels 2.4.*, and that problem was reported to gcc people multiple 
times. But it is still broken in gcc 3.0.1:

bp2.c:414: warning: `sbp2_host_info_lock' defined but not used
capi.c: In function `capi_ioctl':
capi.c:1031: Unrecognizable insn:
(insn/i 1675 3103 3100 (parallel[ capi.c:1031: Internal error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.

So, does anyone have any ideas? That problem is critical because
it makes ISDN (capi 2) unusable with kernels 2.4.* + gcc 3.0.* 

All other things seem to function pretty well with 2.4.9 + 3.0.1.

-- 
Mr. Santeri Kannisto, CTO, sk@sot.com - http://www.sot.com/
Ou SOT Finnish Software Engineering   - fax  +372 5 171 941
Kreutzwaldi 7-4, EE-10124 Tallinn     - tel. +372 5 044 941
ESTONIA                             - http://bestlinux.net/
