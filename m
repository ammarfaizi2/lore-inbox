Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVCARZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVCARZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVCARZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:25:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:39052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261988AbVCARZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:25:00 -0500
Message-ID: <4224A592.1050909@osdl.org>
Date: Tue, 01 Mar 2005 09:25:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ultralinux@vger.kernel.org
Subject: Re: SPARC64: Modular floppy?
References: <200503010153.j211rGXB006246@laptop11.inf.utfsm.cl>
In-Reply-To: <200503010153.j211rGXB006246@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> "David S. Miller" <davem@davemloft.net> said:
> 
>>On Mon, 28 Feb 2005 17:07:43 -0300
>>Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> 
> 
> [...]
> 
> 
>>>So, either the dependencies have to get fixed so floppy can't be modular
>>>for this architecture, or the relevant functions have to move from entry.S
>>>to the module.
> 
> 
>>I think the former is the best solution.  The assembler code really
>>needs to get at floppy.c symbols.
> 
> 
>>From my cursory look the stuff depending on the floppy.c symbols is just
> in the floppy-related code. Can't that be just included in floppy.c?
> (Could be quite a mess, but it looks like short stretches).

The code in entry.S looks self-contained (to me:), so moving it
somewhere else should just be a SMOP (mostly kbuild stuff)....

-- 
~Randy
