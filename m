Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTEJKNC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 06:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTEJKNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 06:13:01 -0400
Received: from palrel11.hp.com ([156.153.255.246]:55201 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263760AbTEJKNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 06:13:00 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16060.54175.634093.943752@napali.hpl.hp.com>
Date: Sat, 10 May 2003 03:25:35 -0700
To: arjanv@redhat.com
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: qla1280 mem-mapped I/O fix
In-Reply-To: <1052561708.1367.0.camel@laptop.fenrus.com>
References: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
	<1052561708.1367.0.camel@laptop.fenrus.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 10 May 2003 12:15:08 +0200, Arjan van de Ven <arjanv@redhat.com> said:

  >> @@ -2634,7 +2634,7 @@
  >> /*
  >> * Get memory mapped I/O address.
  >> */
  >> -	pci_read_config_word (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
  >> +	pci_read_config_dword (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
  >> mmapbase &= PCI_BASE_ADDRESS_MEM_MASK;

  Arjan> shouldn't this be pci_resource_start() ?

Probably should be.  I wanted a minimal fix, because if you start
cleaning up qla1280, it won't stop there... ;-(

	--david
