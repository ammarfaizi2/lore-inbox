Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbSITJtM>; Fri, 20 Sep 2002 05:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbSITJtM>; Fri, 20 Sep 2002 05:49:12 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:44816 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S262027AbSITJtL>;
	Fri, 20 Sep 2002 05:49:11 -0400
Message-ID: <3D8AF01A.7070502@corvil.com>
Date: Fri, 20 Sep 2002 10:53:30 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <3D8A6EC1.1010809@redhat.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> We are pleased to announce the first publically available source
> release of a new POSIX thread library for Linux
[snip]
> called Native POSIX Thread Library, NPTL.

Great! Where does this leave NGPT though? I had assumed that
this was going to be the next pthread implementation in glibc.

also:

-------- Original Message --------
Subject: glibc threading performance
Date: Mon, 16 Sep 2002 10:42:42 +0100
From: Padraig Brady <padraig.brady@corvil.com>
To: Ingo Molnar <mingo@redhat.com>, Ulrich Drepper <drepper@redhat.com>

Hey guys,

I noticed you're looking at threading stuff lately,
and was wondering about this thread:
http://sources.redhat.com/ml/bug-glibc/2001-12/msg00048.html

In summary wouldn't it be better to have a per process
flag that was only set when pthread_create() is called.
If the flag is not set, then you don't need to do locking.
This locking seems to have huge overhead. For e.g. I
patched uniq in textutils to use getc_unlocked() rather
than getc() and got a 300% performance increase!

cheers,
Pádraig.

