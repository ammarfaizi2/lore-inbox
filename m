Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTICPhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTICPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:37:21 -0400
Received: from pinga.salk.edu ([192.31.153.187]:35537 "EHLO pinga.salk.edu")
	by vger.kernel.org with ESMTP id S263432AbTICPhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:37:18 -0400
Date: Wed, 3 Sep 2003 08:37:13 -0700
From: David Chambers <davidc@ccmi.salk.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test{2,4}, gcc, smp problem
Message-Id: <20030903083713.009d4b1b.davidc@ccmi.salk.edu>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Message-flag: Warning: Usage of MS Outlook will stunt your growth.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CCMI-MailScanner-Information: Please contact the ISP for more information
X-CCMI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have recently been trying the 2.6.0-test kernels on an up-to-date Red Hat 9 system (Dual Xeon, 2 GB RAM, Tyan 7505 motherboard).  Being lazy :-) I downloaded arjanv's source RPMs and built from those.  These RPMs apply 2 small patches, one framebuffer related and one implements a noninteractive "make oldconfig", otherwise the 2.6.0 source is untouched.

Compilation of the initial 2.6.0-test2 with gcc 3.2 (Red Hat released version) (while running 2.4.21) went perfectly.  I booted the new 2.6.0-test2 and I have to say I never want to go back to 2.4!  Desktop responsiveness is **much** improved - superb job, guys!.

However...  When I tried to compile 2.6.0-test2 again, (running under 2.6.0-test2) I get irreproducible internal compiler errors or segmentation faults.  I have tracked this down to the use of "make -j4" during the build.  If I disable the multiple job compilation, everything works.  If I so much as use "make -j2" I get the errors again.

Same thing happens with 2.6.0-test4.  I tried upgrading gcc to 3.3.1 (Rawhide rpm) and this has made no difference.  I have not yet tried this with anything but the smp kernel, btw.

So... What am I looking at here?  Problem with hardware? kernel? gcc?  Any comments and suggestions gratefully received!!

- David Chambers
