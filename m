Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbTCWTQo>; Sun, 23 Mar 2003 14:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263150AbTCWTQo>; Sun, 23 Mar 2003 14:16:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26789
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263149AbTCWTQn>; Sun, 23 Mar 2003 14:16:43 -0500
Subject: Re: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: mflt1@micrologica.com.hk, ambx1@neo.rr.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7E0A73.3D00B9CB@megsinet.net>
References: <3E7DE01B.2B6985DF@megsinet.net>
	 <1048443865.10727.36.camel@irongate.swansea.linux.org.uk>
	 <3E7E0A73.3D00B9CB@megsinet.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048452010.10712.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 20:40:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 19:26, M.H.VanLeeuwen wrote:
> Here is the ordering of initcall from System.map file w/ my change.
> I take it that you want isapnp_init after pci*_init also, or is it sufficient
> like it is, after the acpi*_init?

pci and pnpbios must come before isapnp as well. Otherwise IGP based systems
will MCE on boot

