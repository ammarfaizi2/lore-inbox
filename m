Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272205AbRHWDjL>; Wed, 22 Aug 2001 23:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272206AbRHWDjB>; Wed, 22 Aug 2001 23:39:01 -0400
Received: from mail.deja.com ([65.195.161.135]:34576 "EHLO mail.deja.com")
	by vger.kernel.org with ESMTP id <S272205AbRHWDi5>;
	Wed, 22 Aug 2001 23:38:57 -0400
From: "Jeff Busch" <jbusch@half.com>
To: "David Lang" <dlang@diginsite.com>
Cc: <linux-kernel@vger.kernel.org>, <roswell-list@redhat.com>
Subject: RE: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
Date: Wed, 22 Aug 2001 22:39:06 -0500
Message-ID: <NEBBJGKHGENBAPAMDILGGEHJGOAA.jbusch@half.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0108221633280.3868-100000@dlang.diginsite.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have been trying to duplicate a similar problem in my lab that happened
> to me on a production box with 2.4.5. do you have a test that will allow
> you to replicate the problem at will?

ok here's a reply from our developer:

--------------------

probably the best way to reproduce the environment would be to write a
C++ class that has a method on it that goes and maps a file, touches
all the memory in that file, and then returns.  add another method
that takes a number and returns that same number.  then run that code
through swig and write a mod_perl interface to call the first method
then call the second method in a loop (10 times should be good), then
storable::freeze an array of results and print it to stdout.

this ought to emulate the kinds of things we do there.  you might
actually have that method take a number and return a string (literal)
instead of a number, just to exercise swig a little more.

--------------------

Note that the file must be large; maybe 50% greater than physical RAM.

Jeff
