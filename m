Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVBJTJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVBJTJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVBJTHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:07:45 -0500
Received: from smtp07.web.de ([217.72.192.225]:52408 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S261342AbVBJTHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:07:36 -0500
Message-ID: <420BB0F6.8030405@web.de>
Date: Thu, 10 Feb 2005 20:07:34 +0100
From: Michael Renzmann <mrenzmann@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to retrieve version from kernel source (the right way)?
References: <4209C71F.9040102@web.de> <35297.194.237.142.7.1107985448.squirrel@194.237.142.7> <420B07FA.7050309@web.de> <20050210184218.GA9338@mars.ravnborg.org>
In-Reply-To: <20050210184218.GA9338@mars.ravnborg.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sam Ravnborg wrote:
>>otaku@gimli linux-2.6.10 $ make kernelrelease
>>make: *** No rule to make target `kernelrelease'.  Stop.
> I works with the 2.6 kernel.

As Andreas Gruenbacher pointed out, this feature has been implemented 
just about 8 weeks ago. He also gave the following snippet as a backward 
compatible solution:

=== cut ===
echo -e 'foo:\n\t@echo $(KERNELRELEASE)\ninclude Makefile' \
     | make -f-
=== cut ===

This works fine.

Thanks to everyone for your tips and answers.

Bye, Mike
