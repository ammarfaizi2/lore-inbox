Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbQLHPk1>; Fri, 8 Dec 2000 10:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130272AbQLHPkU>; Fri, 8 Dec 2000 10:40:20 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:25329 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129825AbQLHPkK>;
	Fri, 8 Dec 2000 10:40:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0012080938560.11198-100000@viper.haque.net> 
In-Reply-To: <Pine.LNX.4.30.0012080938560.11198-100000@viper.haque.net> 
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 15:08:39 +0000
Message-ID: <2535.976288119@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mhaque@haque.net said:
>  They'd prolly blast through it without reading (You don't think they
> read teh MS agreement when istalling windows do you?) but I bet we
> could argue that they accepted the agreement to protect us. 


tristate 'NTFS file system support (read only)' CONFIG_NTFS_FS
dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_NTFS_RW $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
if [ "$CONFIG_NTFS_RW" = "y" ] ; then
   string '  Enter the magic text to really enable NTFS write' CONFIG_NTFS_MAGICTEXT
fi




#ifdef CONFIG_NTFS_RW
#if CONFIG_NTFS_MAGICTEXT != "I know it will eat my filesystem"
#error you got the magic text wrong
#endif
#endif

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
