Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273358AbRJIHDv>; Tue, 9 Oct 2001 03:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273360AbRJIHDa>; Tue, 9 Oct 2001 03:03:30 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:10001 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S273349AbRJIHDN>;
	Tue, 9 Oct 2001 03:03:13 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200110090703.f9973Z601609@oboe.it.uc3m.es>
Subject: share buffer between user and kernel?
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Tue, 9 Oct 2001 09:03:35 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the currently approved method of sharing a buffer between
userspace and kernelspace, so that I can avoid one or two
copy_to/from_user?

It used to be that one reimplemented mmap to provide the kernel
with some vmalloced memory which one went through reserving, then
the mmap interface automagically provided the right address to
userspace. I get the impression that there are nowadays much
slicker and cleaner ways to do this ... but searching the code
for examples of the absence of copy_to_user is, errm, difficult.

The sound drivers seem to play around in this area, but they
are mapping real physical memory, which I don't want. Is there
an example which uses vmalloced memory?

Or should I just be making a buffer in userspace, then passing
the address to the kernel, then locking it somehow, then collapsing
it to a kernel address? It's going to be about 256K at most.

Suggestions very gratefully received!

Peter
