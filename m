Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262057AbSIYS5d>; Wed, 25 Sep 2002 14:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262056AbSIYS5d>; Wed, 25 Sep 2002 14:57:33 -0400
Received: from mail.webmaster.com ([216.152.64.131]:31137 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S262055AbSIYS5c> convert rfc822-to-8bit; Wed, 25 Sep 2002 14:57:32 -0400
From: David Schwartz <davids@webmaster.com>
To: <cfriesen@nortelnetworks.com>
CC: <pwaechtler@mac.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Wed, 25 Sep 2002 12:02:46 -0700
In-Reply-To: <3D90D4B9.9080802@nortelnetworks.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020925190248.AAA10970@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Sep 2002 17:10:17 -0400, Chris Friesen wrote:
>David Schwartz wrote:

>>The main reason I write multithreaded apps for single CPU systems is to
>>protect against ambush. Consider, for example, a web server. Someone sends
>>it
>>an obscure request that triggers some code that's never run before and has
>>to
>>fault in. If my application were single-threaded, no work could be done
>>until
>>that page faulted in from disk.

>This is interesting--I hadn't considered this as most of my work for the
>past while has been on embedded systems with everything pinned in ram.

	In the usual case, the code faults in.

>Have you benchmarked this?  I was under the impression that the very
>fastest webservers were still single-threaded using non-blocking io.

	It's all about how you define "fastest". If speed means being able to do the 
same thing over and over really quickly, yes. But I also want uniform 
(non-bursty) performance in the face of an unpredictable set of jobs.

	DS



