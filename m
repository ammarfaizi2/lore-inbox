Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSI0ACb>; Thu, 26 Sep 2002 20:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSI0ACb>; Thu, 26 Sep 2002 20:02:31 -0400
Received: from pc132.utati.net ([216.143.22.132]:63389 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261579AbSI0ACb>; Thu, 26 Sep 2002 20:02:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Dan Kegel <dank@kegel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel call chain search tool?
Date: Thu, 26 Sep 2002 15:07:38 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <3D913D58.49D855DB@kegel.com> <1033053348.1269.37.camel@irongate.swansea.linux.org.uk> <3D93331C.86F87359@kegel.com>
In-Reply-To: <3D93331C.86F87359@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020927000451.98A9E398@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 September 2002 12:17 pm, Dan Kegel wrote:

> If only the darn program didn't have so many threads, RLIMIT_AS
> or the no-overcommit patch would be perfect.  I unfortunately can't
> get rid of the threads, so I'm stuck trying to figure out some way
> to kill the right program when the system gets low on memory.
>
> Maybe I should look at giving the OOM killer hints?

The OOM killer should certainly know about threads and thread groups.  If you 
kill one thread, you generally have to kill the whole group because there's 
no way of knowing if that thread was holding a futex or otherwise custodian 
of critical data and thus you just threw the program into la-la land.

> - Dan

Rob
