Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWFUQl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFUQl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWFUQl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:41:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:64389 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932249AbWFUQl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:41:56 -0400
From: Andi Kleen <ak@suse.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] x86_64: Do not use -ffunction-sections for modules
Date: Wed, 21 Jun 2006 18:41:33 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, linux-x86_64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <11509074684035-git-send-email-vsu@altlinux.ru>
In-Reply-To: <11509074684035-git-send-email-vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606211841.33220.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The correct mailing list is still discuss@x86-64.org

On Thursday 01 January 1970 01:00, Sergey Vlasov wrote:
> Currently CONFIG_REORDER uses -ffunction-sections for all code;
> however, creating a separate section for each function is not useful
> for modules and just adds bloat. 

You mean the ELF files are larger? .text/.data size shouldn't
change in theory.

> Moving this option from CFLAGS to 
> CFLAGS_KERNEL shrinks module object files (e.g., the module tree for a
> kernel built with most drivers as modules shrinked from 54M to 46M),
> and decreases the number of sysfs files in /sys/module/*/sections/
> directories.

Thanks applied.

-Andi
