Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbSITOve>; Fri, 20 Sep 2002 10:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbSITOve>; Fri, 20 Sep 2002 10:51:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60933 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262747AbSITOve>;
	Fri, 20 Sep 2002 10:51:34 -0400
Message-ID: <3D8B3708.2060205@mandrakesoft.com>
Date: Fri, 20 Sep 2002 10:56:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] Cleanup (BIN|BCD)_TO_(BCD|BIN) usage/macros
References: <20020917182950.GA726@opus.bloom.county> <3D8776FF.3050504@mandrakesoft.com> <20020920143931.GH726@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> The other thing, is that in general people seem to expect BIN_TO_BCD(X) to
> not return a value, and just convert X.  Would it be better to replace
> CONVERT_x to __x then ?


My gut feeling is that the users in the majority -- the ones that don't 
return a value -- are still abnormal.  Side effects on arguments are the 
rare case in C, even if it is the common case here.

But to answer your question, I think s/CONVERT_x/__x/ is better than 
nothing...

	Jeff


