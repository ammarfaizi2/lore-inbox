Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317975AbSGaTLK>; Wed, 31 Jul 2002 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSGaTLK>; Wed, 31 Jul 2002 15:11:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:49162 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317975AbSGaTLK>;
	Wed, 31 Jul 2002 15:11:10 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207311914.g6VJEG5308283@saturn.cs.uml.edu>
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 31 Jul 2002 15:14:16 -0400 (EDT)
Cc: david_luyer@pacific.net.au (David Luyer), linux-kernel@vger.kernel.org
In-Reply-To: <1028125599.7886.68.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jul 31, 2002 03:26:39 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> On Wed, 2002-07-31 at 13:59, David Luyer wrote:

>>   printf("%d\n", sysconf(_SC_NPROCESSORS_CONF));
>> }
>> luyer@praxis8:~$ ./cpus
>> 4
>> luyer@praxis8:~$ grep 'processor        ' /proc/cpuinfo
>> processor       : 0
>> processor       : 1
>
> In which case I suggest you file a glibc bug. sysconf looks at the /proc
> stuff as I understand it

First you blame ps. Then you blame libc. How about you
place the fault right where it belongs?

Counting processors in /proc/cpuinfo is a joke of an ABI.

Add a proper ABI now, and userspace can transition to it
over the next 4 years.
