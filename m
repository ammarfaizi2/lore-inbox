Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTFKTCC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTFKTCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:02:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10413
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263632AbTFKTB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:01:59 -0400
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030611174629.GC31051@gtf.org>
References: <1055290315109@kroah.com>
	 <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
	 <20030611163837.GA24951@kroah.com>
	 <1055351984.2419.23.camel@dhcp22.swansea.linux.org.uk>
	 <20030611174629.GC31051@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055358790.2419.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 20:13:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 18:46, Jeff Garzik wrote:
> Its an API that doesn't make sense.

Is this a PCI box is a sane thing to ask

> "Is a PCI bus present?"  Further, the IDE code calculating system
> bus speed it should really be calling a PCI callback, not asking "Do
> I have a PCI bus?" and making a guess...  a guess which seems wrong
> in several cases, including my Dual Athlon box w/ 100% 66 Mhz PCI bus.

Wrong. You misunderstand why this is done. We want to know for various
wackomtic old IDE devices and the key to knowing if its going to be
33Mhz is "does it have a PCI bus".

BTW if you want to be pedantic your "fix" is as broken as the original
since PCI root bridges can live on hotpluggable cards on a different
system bus 8)


