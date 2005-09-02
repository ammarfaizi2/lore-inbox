Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVIBUAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVIBUAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVIBUAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:00:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:236 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751044AbVIBUAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:00:13 -0400
Subject: Re: [PATCH] more of sparc32 dependencies fallout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050902191201.GB5155@ZenIV.linux.org.uk>
References: <20050902191201.GB5155@ZenIV.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 21:24:08 +0100
Message-Id: <1125692648.30867.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 20:12 +0100, viro@ZenIV.linux.org.uk wrote:
>  config MOXA_SMARTIO
>  	tristate "Moxa SmartIO support"
> -	depends on SERIAL_NONSTANDARD
> +	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
>  	help


Why mark it "BROKEN" and !SPARC32. Why not mark it (ISA || PCI) ? Its
only available as a plugin card and its apparently working

