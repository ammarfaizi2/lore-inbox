Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRAOX76>; Mon, 15 Jan 2001 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbRAOX7t>; Mon, 15 Jan 2001 18:59:49 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38161 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129704AbRAOX7f>; Mon, 15 Jan 2001 18:59:35 -0500
Date: Mon, 15 Jan 2001 20:09:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rainer Mager <rmager@vgkk.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Oops with 4GB memory setting in 2.4.0 stable
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGKENHCMAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.4.21.0101152003520.834-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jan 2001, Rainer Mager wrote:

> I knew that, I was just testing you all.  ;-)

>>EIP; f889e044 <END_OF_CODE+385bfe34/????>   <=====
Trace; f889d966 <END_OF_CODE+385bf756/????>
Trace; c0140c10 <vfs_readdir+90/ec>
Trace; c0140e7c <filldir+0/d8>
Trace; c0140f9e <sys_getdents+4a/98>
Trace; c0140e7c <filldir+0/d8>

It seems the oops is happening in a module's function.

You have to make ksymoops parse the oops output against a System.map which
has all modules symbols. Load each module by hand with the insmod -m
option ("insmod -m module.o") and _append_ the outputs to System.map.

After that you can run ksymoops against this new System.map. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
