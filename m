Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUDKF2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 01:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUDKF2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 01:28:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:60877 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262235AbUDKF2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 01:28:42 -0400
Subject: Re: want to clarify powerpc assembly conventions in head.S
	and	entry.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4078D42C.1020608@nortelnetworks.com>
References: <4077A542.8030108@nortelnetworks.com>
	 <1081591559.25144.174.camel@gaston>  <4078D42C.1020608@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1081661150.1380.183.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Apr 2004 15:25:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You knew this was coming...  What's special about syscalls?  There's the 
> r3 thing, but other than that...

The whole codepath is a bit different, there's the syscall trace,
we can avoid saving much more registers are syscalls are function
calls and so can clobber the non volatiles, etc...

> Thanks for your help with this stuff.  As I've been slowly wrapping my 
> head around it I've been continuously wishing for some kind of design 
> rules document describing the various paths through the assembly code, 
> along with register conventions and such.  I eventually did find the 
> conventions linked off the penguinppc website, but it was not obvious 
> from just reading the code or the ppc stuff in the Documentation directory.
> 
> Chris
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

