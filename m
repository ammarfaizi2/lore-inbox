Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTEFUYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTEFUYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:24:25 -0400
Received: from exchsrv1.cs.washington.edu ([128.95.3.128]:11543 "EHLO
	exchsrv1.cseresearch.cs.washington.edu") by vger.kernel.org with ESMTP
	id S261759AbTEFUYY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:24:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Buggy drivers/modules needed 
Date: Tue, 6 May 2003 13:36:57 -0700
Message-ID: <2B0E86920B2B9C43A043DA80E447FCBC7BB89A@exchsrv1.cseresearch.cs.washington.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Buggy drivers/modules needed 
Thread-Index: AcMThRZnCM+X5tJxRQm/AqITHJoRPQAif+Dg
From: "Michael Swift" <mikesw@cs.washington.edu>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run drivers with a separate kernel page table, that write-protects
memory not in use by the driver. In addition, I verify that parameters
passed from a driver to the kernel are valid, so the kernel doesn't die
while dereferencing a pointer.

- Mike

-----Original Message-----
From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu] 
Sent: Monday, May 05, 2003 9:08 PM
To: Michael Swift
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buggy drivers/modules needed 


On Mon, 05 May 2003 20:36:32 PDT, Michael Swift
<mikesw@cs.washington.edu>  said:

> I'm working on a Linux patch to prevent buggy modules/drivers from 
> causing the kernel to crash. Instead, the kernel detects a crash in 
> the driver, and trans parently restarts the module. Currently this 
> patch supports network interface card drivers, sound drivers, and file

> systems.

What are you planning to do about protecting a buggy module/driver from
causing a crash by stomping on somebody *elses* memory and corrupting
some unrelated data structure?
