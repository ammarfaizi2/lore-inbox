Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272627AbTHKOHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272616AbTHKOGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:06:42 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:38673 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S272686AbTHKOFk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:05:40 -0400
Subject: Re: 2.6.0-test3-mm1
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030809203943.3b925a0e.akpm@osdl.org>
References: <20030809203943.3b925a0e.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1060610602.6452.3.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 11:03:23 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Em Dom, 2003-08-10 às 00:39, Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm1

 I'm getting this warning with gcc-3.3.1:

drivers/char/keyboard.c: In function `k_fn':
drivers/char/keyboard.c:665: warning: comparison is always true due
to limited range of data type

 gcc seems right, because the ``value'' variable only go to
255 and the size of ``func_table'' in my system is 256.

 Even if gcc transforms unsigned char to a higher in this case, its
not solve the problem, because the value in ``value'' will use only
8 bits (this is made by the K_VAL() macro).

 thanks,

PS: I'm getting this with 2.6.0-test3 too.

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

