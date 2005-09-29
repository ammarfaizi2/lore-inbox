Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVI2Aeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVI2Aeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVI2Aeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:34:50 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:48067 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750951AbVI2Aet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:34:49 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCHv3 00/04] pci_ids: cleanup and removal of unused symbols
Date: Thu, 29 Sep 2005 10:34:20 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <aqamj1do613t0cnkt5m0mheii5flcj3377@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This series of patches cleans up pci_ids.h and removes unused 
symbols:

01/04 remove duplicates and replace indirect assignments with value

02/04 replace source macro constructed symbols with whole symbols

03/04 remove unused symbols from pci_ids.h, those not referenced 
nor defined in the source

04/04 whitespace - get rid of the space / tab mix and fix some cpp 
style comments

Information about this process will appear on:
  http://bugsplatter.mine.nu/kernel/pci_ids/

Current statistics, taken after patches 1 and 2 over 2.6.14-rc2-git7, 
the figures are file line counts:

   2306 symbols-pci_ids.h-define
      0 symbols-pci_ids.h-dups		<<== after patch 1
   2042 symbols-pci_ids.h-new
   2701 symbols-pci_ids.h-orig
    659 symbols-source-absent		<<== removal hitlist
      0 symbols-source-alias-syms
    929 symbols-source-all-singles
    460 symbols-source-all-singles-files
   1916 symbols-source-define		<<== includes local work symbols
    103 symbols-source-define-files
   1184 symbols-source-files-include-pci.h
     29 symbols-source-files-include-pci_ids.h
    142 symbols-source-ifndef
     49 symbols-source-ifndef-files
      0 symbols-source-macro		<<== after patch 2
      0 symbols-source-macro-files
   1647 symbols-source-present

Some numbers above rubbery until info used and compile tested.

Test: compile test with 'make allmodconfig', no PCI_* undefined errors.

Plans:  Perhaps remove that #ifndef construct from 49 files... 

Thanks,
Grant.

