Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281067AbRKTOFy>; Tue, 20 Nov 2001 09:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKTOFe>; Tue, 20 Nov 2001 09:05:34 -0500
Received: from t2.redhat.com ([199.183.24.243]:31219 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281067AbRKTOF3>; Tue, 20 Nov 2001 09:05:29 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200111201303.OAA17296@post.webmailer.de> 
In-Reply-To: <200111201303.OAA17296@post.webmailer.de> 
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre6 compile errors 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Nov 2001 14:05:24 +0000
Message-ID: <16761.1006265124@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arnd@bergmann-dalldorf.de said:
>  CONFIG_PPP_DEFLATE && (CONFIG_CRAMFS || CONFIG_ZISOFS): Symbol
> clashes from two zlib copies (again...). I suppose the symbols in
> drivers/net/zlib.c could all be made static unless a merge of both
> zlib  copies is already planned. 

JFFS2 will conflict too. JFFS2 and PPP can't use the separate zlib at the
moment, because they require compression support and it only does
decompression. PPP may even have trouble when that's fixed, although I think
we eventually concluded it would be OK.

JFFS2 and PPP can share though. 

--
dwmw2


