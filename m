Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbSALSrc>; Sat, 12 Jan 2002 13:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSALSrN>; Sat, 12 Jan 2002 13:47:13 -0500
Received: from pat.uio.no ([129.240.130.16]:17855 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S287293AbSALSrI>;
	Sat, 12 Jan 2002 13:47:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15424.33959.99237.666877@charged.uio.no>
Date: Sat, 12 Jan 2002 19:47:03 +0100
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: [NFS] some strangeness (at least) with linux-2.4.18-NFS_ALL patch
In-Reply-To: <20020112170111.12E601431@shrek.lisa.de>
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de>
	<15423.39344.864108.741338@charged.uio.no>
	<15423.40571.772367.676896@charged.uio.no>
	<20020112170111.12E601431@shrek.lisa.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:

     > Somehow, gcc managed it to create an invalid link in the above
     > sequence.  Really bad is, you cannot get around this within the
     > client. After rm'ing lib/libsensors.so.1 on the server, make
     > install succeeds on the client.

<snip>

     > I can reproduce this now. Do you?

Nope.

gcc -shared -Wl,-soname,libsensors.so.1 -o lib/libsensors.so.1.2.0
lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo
lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc
rm -f lib/libsensors.so.1
ln -sfn libsensors.so.1.2.0 lib/libsensors.so.1
rm -f lib/libsensors.so
ln -sfn libsensors.so.1.2.0 lib/libsensors.so

Could you try just plain 2.4.18-pre3 + 2.4.18-NFS_ALL? That is what I
am running (on both client + server).

Cheers,
   Trond
