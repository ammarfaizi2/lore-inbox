Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWBJQln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWBJQln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWBJQln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:41:43 -0500
Received: from smtpout.mac.com ([17.250.248.83]:18637 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751291AbWBJQlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:41:42 -0500
In-Reply-To: <43EC7EA7.5030105@gmail.com>
References: <20060208202207.GA26682@zeus.uziel.local> <20060210113616.GA17482@hermes.uziel.local> <43EC7EA7.5030105@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <632EF49A-33EB-4FAE-B2E2-F36446F9C8B6@mac.com>
Cc: Christian Trefzer <ctrefzer@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] neofb: add more logic to determine sensibility of register readback
Date: Fri, 10 Feb 2006 11:41:34 -0500
To: "Antonino A. Daplas" <adaplas@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2006, at 06:53, Antonino A. Daplas wrote:
> Christian Trefzer wrote:
>> +		par->PanelDispCntlRegRead = 0;
>> +		par->PanelDispCntlRegRead = 0;
>> +		par->PanelDispCntlRegRead = 0;
>> +		par->PanelDispCntlRegRead = 0;
>> +		par->PanelDispCntlRegRead = 1;
>
> You can save a few lines by
>
> par->PanelDispCntlRegRead = (blank_mode) ? 0 : 1;

How about the really simple so-obvious-its-impossible-to-misread  
solution?

par->PanelDispCntlRegRead = !blank_mode;

Personally I tend to get ?: constructs confused a _lot_, especially  
mistaking the really short ones like x?0:1 and x?1:0.  Those two are  
usually better represented as !x or !!x, respectively.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


