Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271940AbTHMWUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271941AbTHMWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:20:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36281 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271940AbTHMWUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:20:16 -0400
Message-ID: <3F3AB992.4000506@pobox.com>
Date: Wed, 13 Aug 2003 18:20:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hps@intermeta.de
Subject: Re: [BK PATCH] ACPI Updates for 2.4
References: <F760B14C9561B941B89469F59BA3A8470255EECD@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EECD@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This ACPI update also fixes the irq routing issues I was seeing in 
2.4.22-rc2.  Previously, on Intel ICH5, I had to either disable 
CONFIG_ACPI (which makes my 2nd HT CPU disappear) and boot with 
'noapic', or disable CONFIG_SMP and boot with pci=noacpi.  If I did not 
do this, interrupts to the PCI slots would never be delivered.

With this update, 2.4 now matches 2.6 behavior:
full hyperthread, and interrupts routed correctly.

	Jeff



