Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSKTV4S>; Wed, 20 Nov 2002 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSKTV4S>; Wed, 20 Nov 2002 16:56:18 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:63734 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261678AbSKTVzg>; Wed, 20 Nov 2002 16:55:36 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1037831055.3241.97.camel@irongate.swansea.linux.org.uk> 
References: <1037831055.3241.97.camel@irongate.swansea.linux.org.uk>  <EDC461A30AC4D511ADE10002A5072CAD04C7A52A@orsmsx119.jf.intel.com> <25526.1037828842@passion.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>,
       Felix Seeger <seeger@sitewaerts.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 ACPI 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Nov 2002 21:59:30 +0000
Message-ID: <25766.1037829570@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  I guess sonypi could take the ACPI global lock ?

I assume that's not a serious suggestion. Perhaps it could release the 
region while it's not _actually_ using it, and the ACPI code could be fixed 
to not touch regions which it doesn't own.

Or we write proper PM code for sonypi and make it not possible to use both 
sonypi and ACPI at once.

--
dwmw2


