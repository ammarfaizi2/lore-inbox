Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270101AbRIBWiw>; Sun, 2 Sep 2001 18:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270121AbRIBWim>; Sun, 2 Sep 2001 18:38:42 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:221 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S270101AbRIBWii>; Sun, 2 Sep 2001 18:38:38 -0400
Date: Mon, 3 Sep 2001 00:34:37 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: thunder7@xs4all.nl
Cc: parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010903003437.A385@linux-m68k.org>
In-Reply-To: <20010902105538.A15344@middle.of.nowhere> <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk> <20010902195717.A21209@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010902195717.A21209@middle.of.nowhere>; from thunder7@xs4all.nl on Sun, Sep 02, 2001 at 07:57:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 07:57:17PM +0200, thunder7@xs4all.nl wrote:
> 
> --- linux/include/linux/reiserfs_fs.h   Sun Sep  2 21:54:25 2001
> +++ linux-new/include/linux/reiserfs_fs.h       Sun Sep  2 20:47:27 2001
> @@ -924,7 +924,7 @@
>  #define DEH_Visible 2
> 
>  /* 64 bit systems (and the S/390) need to be aligned explicitly -jdm */
> -#if BITS_PER_LONG == 64 || defined(__s390__)
> +#if BITS_PER_LONG == 64 || defined(__s390__) || defined(__hppa__)
>  #   define ADDR_UNALIGNED_BITS  (3)
>  #endif

couldn't reiserfs use asm/unaligned.h like anyone else?
Seems at least sparc and mips may need the same treatment.

Bye
Richard
