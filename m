Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVBXNoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVBXNoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVBXNoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:44:34 -0500
Received: from lx09-hrz.uni-duisburg.de ([134.91.4.50]:17625 "EHLO
	lx09-hrz.uni-duisburg.de") by vger.kernel.org with ESMTP
	id S262348AbVBXNob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:44:31 -0500
Message-ID: <421DDA37.7010300@folkwang-hochschule.de>
Date: Thu, 24 Feb 2005 14:44:23 +0100
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FUTEX deadlock in ping?
References: <421DA915.7020209@uni-duisburg.de> <20050224120750.GA18677@outpost.ds9a.nl>
In-Reply-To: <20050224120750.GA18677@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi bert!

thanks for your reply.

bert hubert wrote:
> On Thu, Feb 24, 2005 at 11:14:45AM +0100, J?rn Nettingsmeier wrote:
> 
> 
>>ever since moving to ldap for passwd/group/shadow/hosts lookup, ping to 
>>a non-reachable host just freezes up and never returns:
>>
>>spunk:~ # strace ping herrnilsson
>>execve("/bin/ping", ["ping", "herrnilsson"], [/* 61 vars */]) = 0
>>uname({sys="Linux", node="spunk", ...}) = 0
>>brk(0)                                  = 0x8063000
>>...
>>...
>>munmap(0x40504000, 4096)                = 0
>>brk(0x80a5000)                          = 0x80a5000
>>uname({sys="Linux", node="spunk", ...}) = 0
>>futex(0x401540f4, FUTEX_WAIT, 2, NULL
>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 
> Try ping -n. This is most likely something else.
>

hmm. ping -n would still have to look up the hostname, and indeed the 
strace is identical (hanging). but when i ping the ip (this is probably 
what you had in mind), it works as expected.

anyway, why would a process block endlessly in a futex?


