Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWG0VXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWG0VXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWG0VXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:23:08 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:3857 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751313AbWG0VXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:23:06 -0400
Date: Thu, 27 Jul 2006 23:23:19 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
Message-Id: <20060727232319.65883c42.khali@linux-fr.org>
In-Reply-To: <44B26439.8070805@gmail.com>
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain>
	<44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain>
	<44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain>
	<44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain>
	<44B248E4.2020506@pol.net>
	<m3y7v14neb.fsf@defiant.localdomain>
	<44B26439.8070805@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony & Krzysztof,

> > I think it would be different if trying to select something which
> > can't be selected automatically resulted in a warning. I think
> > I have to look at it then, but for now I'll use something like
> > "depends on (FB_CIRRUS=m && I2C && I2C_ALGOBIT) ||
> > (FB_CIRRUS=y && I2C=y && I2C_ALGOBIT=y)".
> 
> Well if the i2c code happens to depend on another module, I hope
> that Jean would warn us in a timely manner :-). And even if Jean
> failed to do so, it would immediately result in a compile
> error/warning which should lead to an easy fix.

I2C and I2C_ALGOBIT are very unlikely to ever depend on anything, so
this isn't a problem.

> I still prefer 'select' just because it's easier to parse, but
> either way is okay, though your method takes me a few more seconds
> to understand.

The Right Way (TM) is to depend on I2C but select I2C_ALGOBIT. I have
plans to hide I2C_ALGOBIT from the configuration menu - the user should
never have to explicitely select it, it's only an helper module. So if
you depend on it, you'll be screwed.

-- 
Jean Delvare
