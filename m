Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbTEOPj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTEOPj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:39:57 -0400
Received: from trained-monkey.org ([209.217.122.11]:46354 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S264090AbTEOPj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:39:56 -0400
To: arjanv@redhat.com
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: qla1280 mem-mapped I/O fix
References: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
	<1052561708.1367.0.camel@laptop.fenrus.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 15 May 2003 11:52:45 -0400
In-Reply-To: <1052561708.1367.0.camel@laptop.fenrus.com>
Message-ID: <m3addoqkaa.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Arjan" == Arjan van de Ven <arjanv@redhat.com> writes:

>> @@ -2634,7 +2634,7 @@ /* * Get memory mapped I/O address.  */ -
>> pci_read_config_word (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase); +
>> pci_read_config_dword (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
>> mmapbase &= PCI_BASE_ADDRESS_MEM_MASK;
>> 
>> 
Arjan> shouldn't this be pci_resource_start() ?

Yep,

The existing code is a nightmare, I am working on cleaning this up so
we can get rid of all the I/O ports crap.

Jes
