Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTFKM02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTFKM02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:26:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34730
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264450AbTFKM01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:26:27 -0400
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055290315109@kroah.com>
References: <1055290315109@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 13:37:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 01:11, Greg KH wrote:
>  			/* user supplied value */
>  			system_bus_speed = idebus_parameter;
> -		} else if (pci_present()) {
> +		} else if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) != NULL) {

That is just gross. pci_present() is far more readable even if you make
it an inline in pci.h that is pci_find_device(PCI_ANY_ID, PCI_ANY_ID,
NULL)

Alan

