Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137209AbREKSws>; Fri, 11 May 2001 14:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137210AbREKSwl>; Fri, 11 May 2001 14:52:41 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:28940 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S137209AbREKSvv>; Fri, 11 May 2001 14:51:51 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: marpet@buy.pl (Marek P=?iso-8859-2?Q?=EAtlicki?=),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
Message-ID: <86256A49.0067820E.00@smtpnotes.altec.com>
Date: Fri, 11 May 2001 13:50:59 -0500
Subject: Re: Linux 2.4.4-ac7
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=dGB88ys22tHY5A1kymHhgX55VX1QYIznj7QQaZesXawq9o0Ywb7HQnIB"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=dGB88ys22tHY5A1kymHhgX55VX1QYIznj7QQaZesXawq9o0Ywb7HQnIB
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



I always make mrproper after applying your patches, and I still got exactly the
same problem with nfs that Marek found.  There were no errors or warnings during
the compile of the objects in the fs/nfs directory or the linking of nfs.o.

Wayne




Alan Cox <alan@lxorguk.ukuu.org.uk> on 05/11/2001 12:53:03 PM

To:   marpet@buy.pl (Marek P
--0__=dGB88ys22tHY5A1kymHhgX55VX1QYIznj7QQaZesXawq9o0Ywb7HQnIB
Content-type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-transfer-encoding: quoted-printable


=EAtlicki)
cc:   alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org=
 (bcc:
      Wayne Brown/Corporate/Altec)

Subject:  Re: Linux 2.4.4-ac7


=

--0__=dGB88ys22tHY5A1kymHhgX55VX1QYIznj7QQaZesXawq9o0Ywb7HQnIB
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




--0__=dGB88ys22tHY5A1kymHhgX55VX1QYIznj7QQaZesXawq9o0Ywb7HQnIB--

