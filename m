Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbRESHyo>; Sat, 19 May 2001 03:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbRESHyZ>; Sat, 19 May 2001 03:54:25 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:6921 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S261681AbRESHyS>;
	Sat, 19 May 2001 03:54:18 -0400
Message-ID: <3B06248F.D788B13@yahoo.com>
Date: Sat, 19 May 2001 03:45:19 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.4 i586)
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bad udelay usage in drivers/net/aironet4500_card.c
In-Reply-To: <20010515143707.A18074@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H . J . Lu wrote:
> 
> In 2.4.4, drivers/net/aironet4500_card.c has

>         udelay(100000);
>         udelay(200000);
>         udelay(250000);

> 
> But on ia32, you cannot use more than 20000 for udelay (). You will get
> undefined symbol, __bad_udelay.

mv driver.c driver.c~
sed 's/udelay\( *\)(\([1-9][0-9]*\)000)/mdelay\1(\2)/' <driver.c~>driver.c

...keeps foo(...) or foo (...) as per original author's taste.
            ^           ^
Paul.

