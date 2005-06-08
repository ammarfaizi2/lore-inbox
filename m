Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVFHUyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFHUyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVFHUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:54:33 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:26284 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S261214AbVFHUy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:54:27 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
	<jey89kbmsc.fsf@sykes.suse.de>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Andreas Schwab <schwab@suse.de>, Linus Torvalds
	<torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
	anton@samba.org, linux-kernel@vger.kernel.org
Date: Wed, 08 Jun 2005 22:54:17 +0200
In-Reply-To: <jey89kbmsc.fsf@sykes.suse.de> (Andreas Schwab's message of "Wed,
	08 Jun 2005 22:45:23 +0200")
Message-ID: <87u0k8k1s6.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Wed, 8 Jun 2005, Paul Mackerras wrote:
>>>
>>> * uname(2) doesn't respect PER_LINUX32, it returns 'ppc64' instead
>>>   of 'ppc'
>>
>> I think this is a feature, not a bug, and I suspect you just broke
>> compiling a 64-bit kernel by default on ppc64.
>
> The uname syscall that Paul is referring to (__NR_olduname) isn't
> actually used nowadays any more.  The current uname syscall
> (__NR_uname, which is implemented by ppc64_newuname) already
> translates ppc64 to ppc depending on the personality.

The current code doesn't work like intended, on my G5 both 'linux32
uname -m' and 'linux32 sh -c "uname -m"' return 'ppc64' without the
patch.
With the patch both commands return 'ppc'.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
