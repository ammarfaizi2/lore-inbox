Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267533AbTGLDii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 23:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbTGLDii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 23:38:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13008 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S267533AbTGLDig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 23:38:36 -0400
Date: Fri, 11 Jul 2003 20:53:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 911] New: [x86_64] Badness in pci_find_subsys at drivers/pci/search.c:132 
Message-ID: <162170000.1057981987@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=911

           Summary: [x86_64] Badness in pci_find_subsys at
                    drivers/pci/search.c:132
    Kernel Version: 2.5.75 (gcc version 3.2.3)
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: kernel-bugs@nogin.org
                CC: ak@suse.de


Distribution: Red Hat Rawhide
Hardware Environment: Dual AMD Opteron
Problem Description: 

My log is full of messages:

----------
Badness in pci_find_subsys at drivers/pci/search.c:132

Call Trace:<IRQ> <ffffffff802223c1>{pci_find_subsys+81}
<ffffffff8012006f>{pci_map_single+463}
       <ffffffff801196b3>{pci_map_sg+179} <ffffffff80286617>{ide_build_dmatable+71}
       <ffffffff80286b02>{ide_start_dma+50} <ffffffff80286c89>{__ide_dma_write+57}
       <ffffffff802808aa>{__ide_do_rw_disk+1162}
<ffffffff80277caf>{ide_wait_stat+223}
       <ffffffff8024d9f3>{as_dispatch_request+675}
<ffffffff8027453a>{start_request+554}
       <ffffffff8024456a>{elv_next_request+218}
<ffffffff8027495c>{ide_do_request+956}
       <ffffffff802751c4>{ide_intr+740} <ffffffff80118e7c>{timer_interrupt+668}
       <ffffffff801149ef>{handle_IRQ_event+47} <ffffffff80114dd4>{do_IRQ+308}
       <ffffffff8010f9a0>{default_idle+0} <ffffffff8010f9a0>{default_idle+0}
       <ffffffff801123cd>{ret_from_intr+0}  <EOI>
<ffffffff80136194>{thread_return+0}
       <ffffffff8010f9c7>{default_idle+39} <ffffffff8010f9a0>{default_idle+0}
       <ffffffff8010fa5f>{cpu_idle+31} <ffffffff8044b885>{start_kernel+453}
-------

occuring every few seconds. This did not exist in 2.5.74!

Steps to reproduce: Just boot the system ;-)


