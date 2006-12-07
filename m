Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031634AbWLGGM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031634AbWLGGM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 01:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031638AbWLGGM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 01:12:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:35016 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031634AbWLGGM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 01:12:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=mpG0Wju2IHfe9zEcCN5gTtHzH3LDXQ0tbACaQXgtUr/113vdx/9GjrjGqFISEPHe7mH1ru7ZDDWZ84An17O53R3X8YGG6RconDtd732/+Jja0/y0z/4j9KgDyETv40KOYtpxJF2hii4AUzSyylRBa1hgU1FKy+Y0kC7hVN2UbC4=
Message-ID: <86802c440612062212x18ec0e22xd907aa583f28c7b1@mail.gmail.com>
Date: Wed, 6 Dec 2006 22:12:55 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: sergio@sergiomb.no-ip.org
Subject: Re: [PATCH 2/3] x86: remove duplicated parser for "pci=noacpi"
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1165469027.29517.11.camel@monteirov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86802c440611261523q4bbd4fbbob5dd36db12dd9a01@mail.gmail.com>
	 <1165469027.29517.11.camel@monteirov>
X-Google-Sender-Auth: 533dcb33b43633a8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so first hunk of the patch doesn't have nothing in common with second ,
> and it is different disable acpi_irqs than disable all acpi,
> callacpi_disable_pci () is acpi=off.
>
pci=noacpi mean it will not use acpi for pci bus scan and irq routing setting.
acpi=noirq mean it will only not use irq routing setting.

the problem is that old code in acpi is processing pci=.... for pci subsystem.

YH
