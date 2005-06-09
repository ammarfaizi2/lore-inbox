Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVFIHCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVFIHCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 03:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVFIHCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 03:02:33 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:1164 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S262300AbVFIHCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 03:02:30 -0400
Message-ID: <42A7E973.5080603@blackdown.de>
Date: Thu, 09 Jun 2005 09:02:11 +0200
From: Juergen Kreileder <jk@blackdown.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>	<jey89kbmsc.fsf@sykes.suse.de> <87u0k8k1s6.fsf@blackdown.de> <jed5qwbhfw.fsf@sykes.suse.de>
In-Reply-To: <jed5qwbhfw.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Juergen Kreileder <jk@blackdown.de> writes:
>>The current code doesn't work like intended, on my G5 both 'linux32
>>uname -m' and 'linux32 sh -c "uname -m"' return 'ppc64' without the
>>patch.
> 
> You appear to be using some very old version of glibc.  I can't reproduce
> that here.  Are you sure you aren't using syscall 109 (__NR_olduname)
> instead of 122 (__NR_uname)?

Debian unstable's glibc isn't exactly new but it isn't that old.

I guess others have the seen the problem too, otherwise anybody would
have ignored my bug report and the original patch.


        Juergen
