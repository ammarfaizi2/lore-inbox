Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272070AbTHNAl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272072AbTHNAl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:41:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:9174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272070AbTHNAl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:41:27 -0400
Subject: Re: Linux 2.6.0-test3 (compile statistics)
From: John Cherry <cherry@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813192642.GJ569@fs.tum.de>
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
	 <1060643227.30492.13.camel@cherrypit.pdx.osdl.net>
	 <20030813192642.GJ569@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1060821667.2713.12.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Aug 2003 17:41:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that the MCA legacy warnings are a bit misleading.  Fortunately,
we don't have many multiple line warnings in the build.  I'll see what I
can do to update the script for these kind of warnings.

John

On Wed, 2003-08-13 at 12:26, Adrian Bunk wrote:
> On Mon, Aug 11, 2003 at 04:07:08PM -0700, John Cherry wrote:
> > Compile statistics: 2.6.0-test3
> > Compiler: gcc 3.2.2
> > Script: http://developer.osdl.org/~cherry/compile/compregress.sh
> > 
> >                bzImage       bzImage        modules
> >              (defconfig)  (allmodconfig) (allmodconfig)
> > 
> > 2.6.0-test3  0 warnings     7 warnings    984 warnings
> >...                          ^^^^^^^^^^
> 
> This number is misleading.
> 
> As a result of the "uniq" in your script the warning
> 
>   include/linux/mca-legacy.h:10:2: warning: #warning "MCA legacy - 
>   please move your driver to the new sysfs api"
> 
> that occurs in 8 different files is counted only once although this 
> problem is in eight different files.
> 
> > John
> 
> cu
> Adrian

