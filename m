Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSLQSui>; Tue, 17 Dec 2002 13:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSLQSui>; Tue, 17 Dec 2002 13:50:38 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:55476
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265508AbSLQSuh>; Tue, 17 Dec 2002 13:50:37 -0500
Message-ID: <3DFF7399.40708@redhat.com>
Date: Tue, 17 Dec 2002 10:57:29 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com> 	<3DFF6D4B.3060107@redhat.com> <1040153186.20780.11.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1040153186.20780.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> getppid changes and so I think has to go to kernel (unless we go around
> patching user pages on process exit [ick]).

But this is exactly what I expect to happen.  If you want to implement
gettimeofday() at user-level you need to modify the page.  Some of the
information the kernel has to keep for the thread group can be stored in
this place and eventually be used by some uerlevel code  executed by
jumping to 0xfffff000 or whatever the address is.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

