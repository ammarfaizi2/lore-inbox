Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315227AbSEURCy>; Tue, 21 May 2002 13:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315230AbSEURCx>; Tue, 21 May 2002 13:02:53 -0400
Received: from relay1.pair.com ([209.68.1.20]:45321 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S315227AbSEURCw>;
	Tue, 21 May 2002 13:02:52 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CEA7ECB.8DCD7673@kegel.com>
Date: Tue, 21 May 2002 10:07:23 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: DCOM coming?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siegfried wrote:
> [Let's put DCOM in the kernel.  That's the best way to make
>  sure it's universally available, isn't it?]

Putting stuff in the kernel is very dangerous; it's only done
if there's absolutely no other way.  Since DCOM is just 
a library for doing TCP/IP RPC, kinda, the only reason to put
it in the kernel would be speed.  (That's why RPC code is in
the kernel; the NFS kernel modules need it, and they really
do require maximal speed.)

Somebody *has* put something very similar to DCOM into the
kernel already; see http://korbit.sourceforge.net/
However, that was mostly done as an intellectual exercise;
nobody seriously uses it, and it's not in the main kernel.

Your basic assumption -- that putting DCOM in the kernel is
the best way to make sure it's available to everyone -- is
mistaken.  After all, the program '/bin/ls' is available to
everyone, and it's not in the kernel.  To make DCOM available
to everyone, just implement it as a good user-level library,
and people will pick it up as they need it.

If you want to help, there is a project implementing DCOM on Linux
at http://freedce.sourceforge.net/
Improving that project is the way to go; later, if performance
concerns merit it, you could consider doing whacky things
like moving it into the kernel.

Or you might consider convincing The Open Group to release
their DCOM on Unix compliance test suite as open source.
They'll do it for the right price, I'm pretty sure.
- Dan
