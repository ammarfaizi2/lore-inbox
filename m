Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSDYKPj>; Thu, 25 Apr 2002 06:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSDYKPi>; Thu, 25 Apr 2002 06:15:38 -0400
Received: from imladris.infradead.org ([194.205.184.45]:13063 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313027AbSDYKPh>; Thu, 25 Apr 2002 06:15:37 -0400
Date: Thu, 25 Apr 2002 11:15:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about trap for programmer in mm.h
Message-ID: <20020425111515.A19665@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020425100440.GA5061@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 12:04:40PM +0200, Pavel Machek wrote:
> Hi!
> 
> As suggested by A.Morton:
> 									Pavel
> 
> --- clean/include/linux/mm.h	Thu Apr 18 22:46:17 2002
> +++ linux/include/linux/mm.h	Thu Apr 25 12:01:19 2002
> @@ -291,8 +291,8 @@
>  #define PG_arch_1		13
>  #define PG_reserved		14
>  #define PG_launder		15	/* written out by VM pressure.. */
> -
>  #define PG_private		16	/* Has something at ->private */
> +/* Top 8 bits are used for page's zone in 2.4-ac and 2.5, don't use them */

s/in 2.4-ac and 2.5//
