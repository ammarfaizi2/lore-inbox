Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbREQSER>; Thu, 17 May 2001 14:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbREQSEH>; Thu, 17 May 2001 14:04:07 -0400
Received: from ns.caldera.de ([212.34.180.1]:23269 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261423AbREQSEA>;
	Thu, 17 May 2001 14:04:00 -0400
Date: Thu, 17 May 2001 20:03:34 +0200
Message-Id: <200105171803.f4HI3Yv29128@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: thockin@sun.com (Tim Hockin)
Cc: Linux kernel <linux-kernel@vger.kernel.org>, root@chaos.analogic.com
Subject: Re: Linux-2.4.4 failure to compile
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3B040C80.C2A7BC6@sun.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B040C80.C2A7BC6@sun.com> you wrote:
> "Richard B. Johnson" wrote:
>> 
>> Hello;
>> 
>> I downloaded linux-2.4.4. The basic kernel compiles but the aic7xxx
>> SCSI module that I require on some machines, doesn't.

> The aic7xxx assembler requiring libdb1 is a bungle.  Getting the headers
> for that right on various distros is not easy.  Add to that it requires
> YACC, when most people have bison (yes, a shell script is easy to make, but
> not always an option). 

If make wants to use yacc but you don't have it, it's probably a mistake
in the make(1) configuration - the Makefile uses implicit rules and
distributions not having yacc should not call it in make's implicit rules.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
