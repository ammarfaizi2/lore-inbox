Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136615AbREAOlr>; Tue, 1 May 2001 10:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136517AbREAOlj>; Tue, 1 May 2001 10:41:39 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:5382 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135982AbREAOl3>; Tue, 1 May 2001 10:41:29 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105011440.QAA12760@green.mif.pg.gda.pl>
Subject: Re: iso9660 endianness cleanup patch
To: hpa@transmeta.com
Date: Tue, 1 May 2001 16:40:58 +0200 (CEST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list), torvalds@transmeta.com,
        Andries.Brouwer@cwi.nl
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are you sure that the arguments of the following casting

> +	return le16_to_cpu(*(u16 *)p);

> +	return be16_to_cpu(*(u16 *)p);

> +	return le32_to_cpu(*(u32 *)p);

> +	return be32_to_cpu(*(u32 *)p);

are properly aligned ?
I did not revise the code to check it, but AFAIK improperly aligned
char* pointers cause problem with casting to pointers to 16/32-bit data
on some architectures (I heard of sucj a problem with alpha).

Maybe there was a reason that the original code did operate on bytes here...

Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
