Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUFRIMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUFRIMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 04:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUFRIMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 04:12:45 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:20159 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265037AbUFRIMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:12:39 -0400
From: Duncan Sands <baldrick@free.fr>
To: 4Front Technologies <dev@opensound.com>
Subject: Re: Stop the linux kernel madness - SOLVED!
Date: Fri, 18 Jun 2004 10:12:29 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <40D25477.1050006@opensound.com>
In-Reply-To: <40D25477.1050006@opensound.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406181012.29538.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's the solution we have found:
> 
> With the latest SuSE 2.6.5-7.75 kernel sources:
> 
> The problem is that /lib/modules/2.6.5-7.75/build points to
> /usr/src/linux-2.6.5-7.75-obj which is some kind of wierd directory
> that has:
> 
> .  ..  bigsmp  debug  default  out  smp
> 
> So simply removing this symlink and putting back a link to
> /usr/src/linux-2.6.5-7.75 fixes our problems.
> 
> So the question is who is at fault here?. We used KBUILD to
> build our modules and obviously the build link in /lib/modules/<kernel>/build
> isn't pointing to the correct source tree.

I don't know if this is the solution to your problem, but /usr/src/linux/README.SUSE
says

  (3)  Compile the module(s) by changing into the module source directory
       and typing ``make -C /usr/src/linux
          O=/usr/src/linux-obj/$ARCH/$FLAVOR M=`pwd` modules''.
          Substitute $ARCH and $FLAVOR with the architecture and flavor
          for which to build the module(s).

I hope this helps,

Duncan.
