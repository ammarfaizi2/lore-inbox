Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbSLREbs>; Tue, 17 Dec 2002 23:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbSLREbs>; Tue, 17 Dec 2002 23:31:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6160 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267130AbSLREbr>; Tue, 17 Dec 2002 23:31:47 -0500
Message-ID: <3DFFFBF1.7000507@transmeta.com>
Date: Tue, 17 Dec 2002 20:39:13 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171716020.1362-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 17 Dec 2002, Linus Torvalds wrote:
> 
>>How about this diff? It does both the 6-parameter thing _and_ the
>>AT_SYSINFO addition.
> 
> 
> The 6-parameter thing is broken. It's clever, but playing games with %ebp
> is not going to work with restarting of the system call - we need to
> restart with the proper %ebp.
> 

This confuses me -- there seems to be no reason this shouldn't work as 
long as %esp == %ebp on sysexit.  The SYSEXIT-trashed GPRs seem like a 
bigger problem.

	-hpa


