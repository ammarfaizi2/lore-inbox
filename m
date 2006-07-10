Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWGJO3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWGJO3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWGJO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:29:24 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:43192 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422637AbWGJO3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:29:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eq35F6vpt/p33OoHSVdU6Ajq9O+yisacJkGBQWr1NXkgFOnV90bo7UE2dZWqWi1OsbmAB9IrOKAT70XEMES+M+nbxU4f6eR7FvmrBxdQt2+zSxUMJnNomKbsDIy7A5TNGU9Zr1c2hWmnK+sOTlipSbIKfjlbqZH5CBc+/OOVxKo=
Message-ID: <44B26439.8070805@gmail.com>
Date: Mon, 10 Jul 2006 22:29:13 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: "Antonino A. Daplas" <adaplas@pol.net>, Jean Delvare <khali@linux-fr.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org>	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net> <m3y7v14neb.fsf@defiant.localdomain>
In-Reply-To: <m3y7v14neb.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> "Antonino A. Daplas" <adaplas@pol.net> writes:
> 
>>> You're right here, I don't know why I assumed DEPENDS does it
>>> automatically.
>> Use select.
> 
> It has a known problem - if the "selected" thing changes (requires
> another option etc) things are screwed. With "depends on", you don't
> have to track such changes.
> 
> While near selects (in the same build directory) are IMHO ok, far
> ones are not.
> 
> I think it would be different if trying to select something which
> can't be selected automatically resulted in a warning. I think
> I have to look at it then, but for now I'll use something like
> "depends on (FB_CIRRUS=m && I2C && I2C_ALGOBIT) ||
> (FB_CIRRUS=y && I2C=y && I2C_ALGOBIT=y)".

Well if the i2c code happens to depend on another module, I hope
that Jean would warn us in a timely manner :-). And even if Jean
failed to do so, it would immediately result in a compile
error/warning which should lead to an easy fix.

I still prefer 'select' just because it's easier to parse, but
either way is okay, though your method takes me a few more seconds
to understand.

Tony
