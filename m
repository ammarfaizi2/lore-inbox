Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313691AbSDPOVg>; Tue, 16 Apr 2002 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313692AbSDPOVf>; Tue, 16 Apr 2002 10:21:35 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:783 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313691AbSDPOVe>;
	Tue, 16 Apr 2002 10:21:34 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Anton Altaparmakov <aia21@cantab.net>
Date: Tue, 16 Apr 2002 16:21:04 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: linux-2.4.19-pre7: undefined reference to  `page_cache_
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <28950BF574F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Apr 02 at 14:59, Anton Altaparmakov wrote:
> 
> I have already submitted a patch to fix this earlier today... and in fact 
> it is identical to yours. (-:

> >fs/fs.o: In function `create_data_partitions':
> >fs/fs.o(.text+0x2594d): undefined reference to `page_cache_release'
> >fs/fs.o(.text+0x25a05): undefined reference to `page_cache_release'

But adding #include <linux/pagemap.h> into fs/partitions/check.h
instead of fs/partitions/ldm.c fixes also problem for other partition
schemes, like acorn.c is ...
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
