Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137194AbREKR5G>; Fri, 11 May 2001 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137192AbREKR44>; Fri, 11 May 2001 13:56:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137194AbREKR4h>; Fri, 11 May 2001 13:56:37 -0400
Subject: Re: Linux 2.4.4-ac7
To: marpet@buy.pl (=?iso-8859-2?Q?Marek_P=EAtlicki?=)
Date: Fri, 11 May 2001 18:53:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010511193605.A1160@marek.almaran.home> from "=?iso-8859-2?Q?Marek_P=EAtlicki?=" at May 11, 2001 07:36:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yH68-0001Qn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is the EXTRAVERSION set properly in Makefile? I use the http://www.bzim=
> age.org
> intermediate diff (chosen ~40K to ~2M) from ac6 nd I still have
> 2.4.4-ac6 login prompt (and Makefile says: EXTRAVERSION =3D -ac6).

I forgot to change it

> The other thing I noticed is:
> /lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o: unresolved symbol filemap_f=
> datawait_Rd4250148
> /lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o: unresolved symbol filemap_f=
> datasync_Rf18ce7a1

cp .config ..; make mrproper; cp ../.config .config

I suspect its an unclean build and the exports didnt get done right. At least
I think I fixed these right 8)

