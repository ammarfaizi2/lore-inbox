Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSBKHyn>; Mon, 11 Feb 2002 02:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSBKHye>; Mon, 11 Feb 2002 02:54:34 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:19717 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S287516AbSBKHyV>; Mon, 11 Feb 2002 02:54:21 -0500
Date: Sun, 10 Feb 2002 23:54:17 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 -- Hundreds of compile errors in lib/zlib_deflate/deflate.c
Message-ID: <20020211075417.GB7960@wizard.com>
In-Reply-To: <1013411533.30864.56.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013411533.30864.56.camel@turbulence.megapathdsl.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux/2.5.2 (i686)
X-uptime: 11:18pm  up 4 days, 21:32,  2 users,  load average: 0.00, 0.08, 0.09
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2002 at 11:12:12PM -0800, Miles Lane wrote:
> I believe this is a bug in the configuration scripts or data.
> I ran "make oldconfig" over an older .config file.  If there
> is a logic error here, oldconfig did not catch it.  Also, 
> I think I probably enabled these options accidentally when 
> running "make oldconfig" for 2.4.5-pre6. 
> 
> # CONFIG_CRC32 is not set
> CONFIG_ZLIB_INFLATE=m
> CONFIG_ZLIB_DEFLATE=m
> 

        I hope you are meaning 2.5.4, as CONFIG_ZLIB_DEFLATE, and CONFIG_CRC32 
are not present in 2.4.5.

        IIRC, the solution for this was:

SOURCEDIR=/usr/src/linux
mv $SOURCEDIR/linux/zutil.h $SOURCEDIR/include/linux
mv $SOURCEDIR/linux/zconf.h $SOURCEDIR/include/linux
rmdir $SOURCEDIR/linux

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

