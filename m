Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbTIEUyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbTIEUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:53:44 -0400
Received: from [205.200.104.254] ([205.200.104.254]:10190 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S265697AbTIEUx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:53:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Fri, 5 Sep 2003 15:53:27 -0500
Message-ID: <18DFD6B776308241A200853F3F83D50727B4@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Thread-Index: AcNz7XkN0TU6Z7nWQWKmUTWTA7PocgAAF6Hg
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mike Fedyk [mailto:mfedyk@matchmail.com]
> Here is one thing we don't have standardized across the entire Linux
> distribution landscape.
> 
> What you need is a project that will take the top 10 
> distributions, and do
> this however each distribution does their thing:
> 
>  o identify the current kernel running (you're going to use the kernel
>    you're running, right?)

Not to mention on boot-up check to make sure the module still loads 
without warnings on the current kernel (or make sure the module exists 
in the current /lib/modules directory.
   
>  o download the kernel source for the running kernel

Problem: Most distributors modify their kernel somewhat.  Some enough 
to cause binary module incompatibility with the 'stock' kernel.  
Matching running kernel and source code kernel would be tricky, to
say the least.
 
>  o install the source in some temporary location

Why not just make the includes directory get installed somewhere.  
Somewhere like /lib/modules/`uname -r`/build/includes (especially since
make install puts a symlink at /lib/modules/`uname -r`/build anyway)
You also need to prep the extracted kernel with the proper .config, etc.
which isn't always in the source package from some distributors.

>  o compile against the downloaded kernel source
> 
>  o install the module under /lib/modules
> 
>  o load the module (with the corect optional parameters)

The biggest problem is people not having installed the C compiler, and 
related tools.  Or having not installed the kernel headers matching 
their version of the kernel.
