Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUD1Tip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUD1Tip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUD1TiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:38:19 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:2217 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S265010AbUD1RhX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:37:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BK PATCH] add SMBIOS tables to sysfs
Date: Wed, 28 Apr 2004 12:37:19 -0500
Message-ID: <0960978B185D2848BF5BBAE1BFB343E104F581@ausx2kmps315.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] add SMBIOS tables to sysfs
Thread-Index: AcQtQRIGJnJy6rFaTCSp/wP5rb0piwABVVzQ
From: <Michael_E_Brown@Dell.com>
To: <greg@kroah.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Apr 2004 17:37:20.0272 (UTC) FILETIME=[7509C900:01C42D47]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good. You can go ahead and add it to your tree. 

I do have one question, though. Here:

> +static struct kobj_type ktype_smbios = {
> +	.sysfs_ops	= &smbios_attr_ops,
> +	.default_attrs	= def_attrs,
> +	/* statically allocated, no release method necessary */
> +};

I have no .release method because I have not kmalloc'ed any 
instances of this struct. Do I need to re-add a release
method here?
--
Michael
