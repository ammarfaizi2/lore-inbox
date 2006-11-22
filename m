Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbWKVBDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbWKVBDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966983AbWKVBDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:03:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:14765 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966982AbWKVBDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:03:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E/oNw520QqZv37IKFR8TDkzl3cxxaJXYBDZcthoog3uAu18BXpjRlPSnrcPEh1ADy7EFa4fZwSE10DmEvaZ8lKJDr0rtNYkiuvRo33wmv8wh1a5iEjXSrfDOhZGmWLASqYiSgDWQi5Cz9z+rpMDvjufpCh+UKR32fYVYH1EQzdw=
Message-ID: <4563A1E3.1030703@gmail.com>
Date: Wed, 22 Nov 2006 10:03:31 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] ata_piix: IDE mode SATA patch for Intel ICH9
References: <39B20DF628532344BC7A2692CB6AEE07A5A310@orsmsx420.amr.corp.intel.com>
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07A5A310@orsmsx420.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaston, Jason D wrote:
> Did this come through ok, using Evolution, or do I need to try a
> different email client and send again?

It's wrapped and more comments below.

> -----Original Message-----
> From: Gaston, Jason D 
> Sent: Tuesday, November 21, 2006 2:52 PM
> To: jgarzik@pobox.com; linux-ide@vger.kernel.org;
> linux-kernel@vger.kernel.org; Gaston, Jason D
> Subject: [PATCH 2.6.19-rc6] ata_piix: IDE mode SATA patch for Intel ICH9
> 
> This patch adds the Intel ICH9 IDE mode SATA controller DID's.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20
> 04:58:48.000000000 -0800
> +++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-20
> 06:15:12.000000000 -0800

Above two lines are wrapped.

> @@ -127,6 +127,7 @@
>  	ich6_sata_ahci		= 8,
>  	ich6m_sata_ahci		= 9,
>  	ich8_sata_ahci		= 10,
> +	ich9_sata_ahci		= 11,

AFAICS, ich9 isn't different from ich8.  Any reason not to simply use 
ich8_sata_ahci?

[--snip--]
> +static const struct piix_map_db ich9_map_db = {
> +	.mask = 0x3,
> +	.port_enable = 0x3,
> +	.present_shift = 8,

I guess this patch is against libata-dev#upstream-fixes.  Just FYI 
.present_shift is gone in libata-dev#upstream.

-- 
tejun
