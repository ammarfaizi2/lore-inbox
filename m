Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbTA1Rqs>; Tue, 28 Jan 2003 12:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTA1Rqs>; Tue, 28 Jan 2003 12:46:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30593
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267675AbTA1Rqr>; Tue, 28 Jan 2003 12:46:47 -0500
Subject: Re: PID of multi-threaded core's file name is wrong in 2.5.59
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Robert Love <rml@tech9.net>, MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128174953.GA23424@nevyn.them.org>
References: <20030125.135611.74744521.maeda@jp.fujitsu.com>
	 <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk>
	 <20030128154541.GA7269@nevyn.them.org> <1043774823.9069.59.camel@phantasy>
	 <20030128173949.GA23077@nevyn.them.org> <1043775771.9069.63.camel@phantasy>
	 <20030128174953.GA23424@nevyn.them.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043779796.24849.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 18:49:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 17:49, Daniel Jacobowitz wrote:
> > Are you telling me only one thread per thread group can coredump,
> > period?  So if two of them segfault (say concurrently on two different
> > processors) only one will win the race to dump and the others will
> > simply exit?
> 
> That's right.  The dump will include all the threads anyway, now.

In which case using tgid is probably the right thing. 
