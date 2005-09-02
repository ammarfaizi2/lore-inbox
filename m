Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVIBUDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVIBUDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVIBUDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:03:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10712
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751065AbVIBUDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:03:44 -0400
Date: Fri, 02 Sep 2005 13:03:43 -0700 (PDT)
Message-Id: <20050902.130343.53230378.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Cc: viro@ZenIV.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more of sparc32 dependencies fallout
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1125692648.30867.35.camel@localhost.localdomain>
References: <20050902191201.GB5155@ZenIV.linux.org.uk>
	<1125692648.30867.35.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] more of sparc32 dependencies fallout
Date: Fri, 02 Sep 2005 21:24:08 +0100

> On Gwe, 2005-09-02 at 20:12 +0100, viro@ZenIV.linux.org.uk wrote:
> >  config MOXA_SMARTIO
> >  	tristate "Moxa SmartIO support"
> > -	depends on SERIAL_NONSTANDARD
> > +	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
> >  	help
> 
> 
> Why mark it "BROKEN" and !SPARC32. Why not mark it (ISA || PCI) ? Its
> only available as a plugin card and its apparently working

He marked it BROKEN "OR" !SPARC32, not "AND".
Also, SPARC32 supports PCI on Javastation machines.

