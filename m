Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293699AbSCFRHC>; Wed, 6 Mar 2002 12:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293696AbSCFRG4>; Wed, 6 Mar 2002 12:06:56 -0500
Received: from mnh-1-27.mv.com ([207.22.10.59]:10759 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293699AbSCFRGU>;
	Wed, 6 Mar 2002 12:06:20 -0500
Message-Id: <200203061708.MAA02691@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 10:03:57 CST."
             <200203061603.KAA21855@tomcat.admin.navo.hpc.mil> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 12:08:09 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pollard@tomcat.admin.navo.hpc.mil said:
> Currently the only way to ensure that the memory IS available is to
> modify every page at startup. Yes it will swap the modified pages.

Currently, yes.

But with Alan says his address space accounting will prevent mmaps from
succeeding if populating them would OOM the system, which gives you want
you want and which sounds like the right thing.  The 8 64M UMLs will run
without needing to touch all their pages at bootup and without fear of being
killed later.  If the 9th UML would be in danger of random death, then it
will never get off the ground.

Note that this doesn't help when the UMLs are under a smaller limit than 
RAM + .5 * swap or whatever as happens when they are mmapping from tmpfs.
That's the situation that I'm concerned about.

				Jeff

