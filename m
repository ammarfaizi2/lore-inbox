Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUDKF6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 01:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUDKF6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 01:58:21 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:5163
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S262272AbUDKF6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 01:58:19 -0400
thread-index: AcQfilREosVlG4lITMygxvL69uEFDQ==
X-Sieve: Server Sieve 2.2
Subject: Re: want to clarify powerpc assembly conventions in head.Sand	entry.S
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: <Administrator@vger.kernel.org>
Cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Message-ID: <000001c41f8a$54474000$d100000a@sbs2003.local>
In-Reply-To: <4078D42C.1020608@nortelnetworks.com>
References: <4077A542.8030108@nortelnetworks.com> <1081591559.25144.174.camel@gaston>  <4078D42C.1020608@nortelnetworks.com>
Content-Type: text/plain;
	charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Apr 2004 07:00:45 +0100
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
Content-Class: urn:content-classes:message
X-me-spamlevel: not-spam
Importance: normal
X-me-spamrating: 2.971760
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 11 Apr 2004 06:00:45.0343 (UTC) FILETIME=[544BFAF0:01C41F8A]
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


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


