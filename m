Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUAUCYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 21:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUAUCYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 21:24:25 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:50353 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261262AbUAUCYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 21:24:24 -0500
Message-ID: <400DE2DA.8060001@metaparadigm.com>
Date: Wed, 21 Jan 2004 10:24:26 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Zan Lynx <zlynx@acm.org>, Bart Samwel <bart@samwel.tk>,
       Ashish sddf <buff_boulder@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>  <Pine.LNX.4.53.0401161659470.31455@chaos>  <200401171359.20381.bart@samwel.tk>  <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk>  <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk>  <Pine.LNX.4.53.0401191521400.8389@chaos> <400C4B17.3000003@samwel.tk>  <Pine.LNX.4.53.0401201000490.11497@chaos> <1074620079.22023.26.camel@localhost.localdomain> <Pine.LNX.4.53.0401201306030.12044@chaos>
In-Reply-To: <Pine.LNX.4.53.0401201306030.12044@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/04 02:10, Richard B. Johnson wrote:
> 
> Well you just fell into the usual trap of using the "C-like"
> capabilities of C++ to call a 'C' function. If you are going
> to use 'C' library functions, you don't use an object-oriented
> language to call them. That is using a hatchet like a hammer.
> 
> I did not malign C++. I used it as it was designed and let
> the chips fall where they may.

Apple has succedded in using C++ in their kernel. Its IOKit uses
an embedded subset of C++ (no exceptions, RTTI, non-trivial
descructors, etc) as part of their device driver framework.

The features they keep; polymorhism, inheritance, encapsulation
provide for a very clean and easily extensible framework.

Writing IOKit drivers is much cleaner than using plain C
without out all the structures with pointers to functions
(explicit implementation of virtual functions and a lot of
casting of (void*) and/or unions).

http://developer.apple.com/documentation/DeviceDrivers/Conceptual/IOKitFundamentals/About/chapter_1_section_1.html

Although this could all be done in C (as is all the OO stuff in
linux like VFS, block and chardevs, etc), it is certainly much
cleaner in C++.

Although horses for courses, we all know C++ won't fly in
the linux kernel. Just I think 'embedded C++' which is an
actual specification and a genuine superset of C and subset
of C++ retaining safre features for kernels can't be ruled
on on technical merits but rather only on personal opinion
of language choice. Personally i prefer Linux's more explicit
OO implmentation with the use of stuctures with pointers to
functions (virtual functions) although not sure there is a
really clean pattern used for inheritance (unions and void*
private pointers) and encapsulation (static function bounday).

~mc

