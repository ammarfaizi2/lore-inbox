Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSILVT4>; Thu, 12 Sep 2002 17:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319318AbSILVTb>; Thu, 12 Sep 2002 17:19:31 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:20128 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S319340AbSILVT0> convert rfc822-to-8bit; Thu, 12 Sep 2002 17:19:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Thunder from the hill <thunder@lightweight.ods.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Killing/balancing processes when overcommited
Date: Thu, 12 Sep 2002 16:19:53 -0500
User-Agent: KMail/1.4.1
Cc: Jim Sibley <jlsibley@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, <riel@conectiva.com.br>
References: <Pine.LNX.4.44.0209121441060.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209121441060.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209121619.53111.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 03:43 pm, Thunder from the hill wrote:
> Hi,
>
> On 12 Sep 2002, Alan Cox wrote:
> > On Thu, 2002-09-12 at 20:08, Thunder from the hill wrote:
> > > These problems can be solved via ulimit. I was referring to things
> > > like rsyncd which was blowing up under certain situations, but runs
> > > under a trusted account (say UID=0). In order to condemn it you'd need
> > > the setup I've mentioned.
> >
> > Ulimit won't help you one iota
>
> Why so pessimistic? You can ban users using ulimit, as you know. (You will
> always remember when you wake up and your memory is ulimited to 1MB.)
>
> 			Thunder

ulimit is a per login limit, not a global per user limit. The sum of all user
logins can still exceed the available memory. Even a large number of
simultaneous network connections (telnetd/sshd) can drive a system OOM.

Now, which of these processes should be killed?
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
