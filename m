Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbSLRUG1>; Wed, 18 Dec 2002 15:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbSLRUG1>; Wed, 18 Dec 2002 15:06:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56333 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267421AbSLRUG0>; Wed, 18 Dec 2002 15:06:26 -0500
Message-ID: <3E00D716.1010503@transmeta.com>
Date: Wed, 18 Dec 2002 12:14:14 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Terje Eggestad <terje.eggestad@scali.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <1040216143.23393.1427.camel@pc-16.office.scali.no>
In-Reply-To: <1040216143.23393.1427.camel@pc-16.office.scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad wrote:
> what about:
> 
> int (*_vsyscall) (int, ...);
> _vsyscall = mmap(NULL, getpagesize(),  PROT_READ|PROT_EXEC,
> MAP_VSYSCALL, , ); 
> 
> or if you're afraid of running out of MAP_* flags:
> 
> fd = open("/dev/vsyscall", );
> _vsyscall = mmap(NULL, getpagesize(),  PROT_READ|PROT_EXEC, MAP_SHARED,
> fd, 0);
> 
> Then you can leisurely map it in just after the programs text segment. 
> 

Very ugly -- then the application has to do indirect calls.

	-hpa


