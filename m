Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbTHYKBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTHYKBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:01:08 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6663 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261720AbTHYKBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:01:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] Fix ide unregister vs. driver model
Date: Mon, 25 Aug 2003 13:01:00 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1061730317.31688.10.camel@gaston>
In-Reply-To: <1061730317.31688.10.camel@gaston>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308251301.00267.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 August 2003 16:05, Benjamin Herrenschmidt wrote:
>  static void hwif_register (ide_hwif_t *hwif)
>  {
>  	/* register with global device tree */
>  	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
>  	hwif->gendev.driver_data = hwif;
> +	if (hwif->gendev.parent == NULL) {
>  	if (hwif->pci_dev)
>  		hwif->gendev.parent = &hwif->pci_dev->dev;
>  	else
>  		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
> +	}

inner if() should be indented
--
vda
