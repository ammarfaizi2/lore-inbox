Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTGOVCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbTGOVCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:02:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46054 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269676AbTGOVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:01:59 -0400
Date: Tue, 15 Jul 2003 23:16:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1-ac1: cs4281m.c doesn't compile
Message-ID: <20030715211642.GQ10191@fs.tum.de>
References: <200307142016.h6EKGDe02631@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307142016.h6EKGDe02631@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:16:12PM -0400, Alan Cox wrote:
>...
> 2.5.75-ac (never released) differences remaining unmerged
>...
> o	CS4281 fixes for new audio (incomplete)		(me)
>...

FYI, it doesn't compile:

<--  snip  -->

...
  CC      sound/oss/cs4281/cs4281m.o
sound/oss/cs4281/cs4281m.c: In function `dealloc_dmabuf':
sound/oss/cs4281/cs4281m.c:1758: warning: implicit declaration of 
function `free_dmabuf'
sound/oss/cs4281/cs4281m.c:1767: warning: implicit declaration of 
function `free_dmabuf2'
sound/oss/cs4281/cs4281m.c: In function `cs4281_mmap':
sound/oss/cs4281/cs4281m.c:3224: warning: implicit declaration of 
function `vm_pgoff'
sound/oss/cs4281/cs4281m.c: In function `cs4281_probe':
sound/oss/cs4281/cs4281m.c:4500: warning: implicit declaration of 
function `cs_pm_register'
sound/oss/cs4281/cs4281m.c:4500: error: `PM_PCI_DEV' undeclared (first 
use in this function)
sound/oss/cs4281/cs4281m.c:4500: error: (Each undeclared identifier is 
reported only once
sound/oss/cs4281/cs4281m.c:4500: error: for each function it appears 
in.)
sound/oss/cs4281/cs4281m.c:4500: warning: implicit declaration of 
function `PM_PCI_ID'
sound/oss/cs4281/cs4281m.c:4500: error: `cs4281_pm_callback' undeclared 
(first use in this function)
sound/oss/cs4281/cs4281m.c:4500: warning: assignment makes pointer from 
integer without a cast
sound/oss/cs4281/cs4281m.c:4506: error: dereferencing pointer to 
incomplete type
sound/oss/cs4281/cs4281m.c: At top level:
sound/oss/cs4281/cs4281m.c:4601: error: `CS4281_SUSPEND_TBL' undeclared 
here (not in a function)
sound/oss/cs4281/cs4281m.c:4601: error: initializer element is not 
constant
sound/oss/cs4281/cs4281m.c:4601: error: (near initialization for 
`cs4281_pci_driver.suspend')
sound/oss/cs4281/cs4281m.c:4602: error: `CS4281_RESUME_TBL' undeclared 
here (not in a function)
sound/oss/cs4281/cs4281m.c:4602: error: initializer element is not 
constant
sound/oss/cs4281/cs4281m.c:4602: error: (near initialization for 
`cs4281_pci_driver.resume')
sound/oss/cs4281/cs4281m.c: In function `cs4281_cleanup_module':
sound/oss/cs4281/cs4281m.c:4624: warning: implicit declaration of 
function `cs_pm_unregister_all'
sound/oss/cs4281/cs4281m.c:4624: error: `cs4281_pm_callback' undeclared 
(first use in this function)
In file included from sound/oss/cs4281/cs4281pm-24.c:28,
                 from sound/oss/cs4281/cs4281m.c:4646:
include/linux/pm.h: At top level:
include/linux/pm.h:60: error: `PM_PCI_DEV' used prior to declaration
In file included from sound/oss/cs4281/cs4281m.c:4646:
sound/oss/cs4281/cs4281pm-24.c:45: error: `cs4281_pm_callback' used 
prior to declaration

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

