Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRDYWD5>; Wed, 25 Apr 2001 18:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRDYWDs>; Wed, 25 Apr 2001 18:03:48 -0400
Received: from jalon.able.es ([212.97.163.2]:43968 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131376AbRDYWDd>;
	Wed, 25 Apr 2001 18:03:33 -0400
Date: Thu, 26 Apr 2001 00:03:25 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Doug McNaught <doug@wireboard.com>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, tim@tjansen.de,
        linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Message-ID: <20010426000325.A6621@werewolf.able.es>
In-Reply-To: <01042522404901.00954@cookie> <200104252116.QAA46520@tomcat.admin.navo.hpc.mil> <20010425235000.A3432@werewolf.able.es> <m34rvcy73o.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m34rvcy73o.fsf@belphigor.mcnaught.org>; from doug@wireboard.com on Wed, Apr 25, 2001 at 23:58:35 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.25 Doug McNaught wrote:
> "J . A . Magallon" <jamagallon@able.es> writes:
> 
> > Question: it is possible to redirect the same fs call (say read) to
> different
> > implementations, based on the open mode of the file descriptor ? So, if
> > you open the entry in binary, you just get the number chunk, if you open
> > it in ascii you get a pretty printed version, or a format description like
> 
> There is no distinction between "text" and "binary" modes on a file
> descriptor.  The distinction exists in the C stdio layer, but is a
> no-op on Unix systems.
> 

Yep, realized after the post, fopen() is a wrapper for open(). The idea
is to (someway) set the proc entry in verbose vs fast-binary mode for
reads. Perhaps an ioctl() or an fcntl() or something similar.
So the verbose mode gives the field names, and the binary mode just
gives the numbers. Applications that know what are reading can just
read binary data, and fast.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac14 #1 SMP Wed Apr 25 02:07:45 CEST 2001 i686

