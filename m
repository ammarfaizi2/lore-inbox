Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVJ0WEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVJ0WEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVJ0WD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:03:57 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:46922 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932660AbVJ0WDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:03:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Kylene Jo Hall <kjhall@us.ibm.com>, selhorst@crypto.rub.de,
       linux-kernel@vger.kernel.org, castet.matthieu@free.fr
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
X-Message-Flag: Warning: May contain useful information
References: <435FB8A5.803@crypto.rub.de> <435FBFC4.5060508@free.fr>
	<4360B889.1010502@crypto.rub.de>
	<1130422052.4839.134.camel@localhost.localdomain>
	<20051027145535.0741b647.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 27 Oct 2005 15:03:49 -0700
In-Reply-To: <20051027145535.0741b647.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 27 Oct 2005 14:55:35 -0700")
Message-ID: <52zmouvcqi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 27 Oct 2005 22:03:50.0636 (UTC) FILETIME=[4FFEF2C0:01C5DB42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, a few comments on your trivial comments:

    > -static int tpm_atml_send(struct tpm_chip *chip, u8 * buf, size_t count)
    > +static int tpm_atml_send(struct tpm_chip *chip, u8  *buf, size_t count)

There's still an extra space there I think.

    > -	data = kmalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
    > +	data = kxalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);

When did we add kxalloc()?  And what does it do?

    > -ssize_t tpm_write(struct file * file, const char __user * buf,
    > +ssize_t tpm_write(struct file * file, const char __user *buf,

Why delete one space between * and buf but not the one between * and file?

 - R.
