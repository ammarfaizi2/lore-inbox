Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTFXSAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTFXSAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:00:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262703AbTFXSAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:00:03 -0400
Subject: Re: 2.5.73 compile results
From: John Cherry <cherry@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030624173900.GV3710@fs.tum.de>
References: <1056475577.9839.110.camel@cherrypit.pdx.osdl.net>
	 <20030624173900.GV3710@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1056478596.9839.118.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Jun 2003 11:16:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, the build continues even when it runs into compile or
link errors.  So if a binary impacts multiple components in the build,
it results in multiple errors.

The root of the nine errors is...

fs/partitions/acorn.c: In function `adfspart_check_EESOX':
fs/partitions/acorn.c:541: `first_sector' undeclared (first use in this
function)
fs/partitions/acorn.c:541: (Each undeclared identifier is reported only
once
fs/partitions/acorn.c:541: for each function it appears in.)
fs/partitions/acorn.c:550: `hd' undeclared (first use in this function)
fs/partitions/acorn.c:551: warning: implicit declaration of function
`add_gd_partition'
fs/partitions/acorn.c:551: `minor' undeclared (first use in this
function)
make[2]: [fs/partitions/acorn.o] Error 1 (ignored)

Sorry for the confusion....but at least it got your attention!  :)

John


On Tue, 2003-06-24 at 10:39, Adrian Bunk wrote:
> On Tue, Jun 24, 2003 at 10:26:18AM -0700, John Cherry wrote:
> > Compile statistics: 2.5.73
> > Compiler: gcc 3.2.2
> > Script: http://www.osdl.org/archive/cherry/stability/compregress.sh
> > 
> >           bzImage       bzImage        modules
> >         (defconfig)  (allmodconfig) (allmodconfig)
> > 
> > 2.5.73  2 warnings    11 warnings   1347 warnings
> >         0 errors       9 errors       43 errors
> >...
> 
> Your counting is a bit strange, with bzImage of allmodconfig there's
> exactly one compile error that is counted nine times (there are later 
> eight errors since the file that failed to compile isn't present).
> 
> cu
> Adrian

