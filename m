Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263117AbREWPCP>; Wed, 23 May 2001 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbREWPCG>; Wed, 23 May 2001 11:02:06 -0400
Received: from zeus.kernel.org ([209.10.41.242]:11754 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263117AbREWPBz>;
	Wed, 23 May 2001 11:01:55 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105231458.QAA22388@sunrise.pg.gda.pl>
Subject: Re: [timer] max timeout
To: sebastien.person@sycomore.fr (sebastien person)
Date: Wed, 23 May 2001 16:58:15 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (liste noyau linux)
In-Reply-To: <20010523162801.38dabdff.sebastien.person@sycomore.fr> from "sebastien person" at May 23, 2001 04:28:01 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"sebastien person wrote:"
> Is it bad to do the following call ?
> 
> 	mod_timer(&timer, jiffies+(0.1*HZ));

Yes, it is bad. Don't use floating point in the kernel if you don't need.

> that might fire the timer 1/10 second later.

HZ/10 is much better ...

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
