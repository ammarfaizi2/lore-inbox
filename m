Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSFEANy>; Tue, 4 Jun 2002 20:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317513AbSFEANx>; Tue, 4 Jun 2002 20:13:53 -0400
Received: from fungus.teststation.com ([212.32.186.211]:20492 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S317512AbSFEANw>; Tue, 4 Jun 2002 20:13:52 -0400
Date: Wed, 5 Jun 2002 02:13:10 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Philippe De Muyter <phdm@macqel.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: smbfs and >2Gb files
In-Reply-To: <200206031318.g53DIpS08552@mail.macqel.be>
Message-ID: <Pine.LNX.4.44.0206050205550.13561-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Philippe De Muyter wrote:

> --- include/linux/smb.hbk	Fri May 31 16:43:54 2002
> +++ include/linux/smb.h	Fri May 31 17:55:49 2002
> @@ -85,7 +85,7 @@
>  	uid_t		f_uid;
>  	gid_t		f_gid;
>  	kdev_t		f_rdev;
> -	off_t		f_size;
> +	size_t		f_size;
>  	time_t		f_atime;
>  	time_t		f_mtime;
>  	time_t		f_ctime;
> 
> Is it possible to incorporate that in the official linux kernel tree ?

Doesn't this just allow smbfs to list the file? If you tried to read all
of it you'd only get the first 2G of it (or is it 4 ...), repeated over
and over.


2.5 has proper support for large files on smbfs, for 2.4 there is a patch
here:
	http://www.hojdpunkten.ac.se/054/samba/index.html
(if you can reach that site, the admins have been very "creative" lately ...)

If anything is going into 2.4 I'd prefer if that was it. Maybe for 2.4.20,
I have had some positive reports on that. Note that you need to patch
samba or else the server won't know that the client supports large files.

/Urban

