Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVDGWG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVDGWG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVDGWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:06:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40968 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262382AbVDGWGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:06:24 -0400
Date: Fri, 8 Apr 2005 00:06:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steve French <smfrench@austin.rr.com>, Steven French <sfrench@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cifs: cleanup asn1.c - kfree
Message-ID: <20050407220622.GE4325@stusta.de>
References: <Pine.LNX.4.62.0504042300520.2496@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504042300520.2496@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 11:01:45PM +0200, Jesper Juhl wrote:
> Remove redundant NULL pointer check before calling kfree().
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> 
> --- linux-2.6.12-rc1-mm4/fs/cifs/asn1.c.with_patch1	2005-04-04 22:25:50.000000000 +0200
> +++ linux-2.6.12-rc1-mm4/fs/cifs/asn1.c	2005-04-04 22:33:34.000000000 +0200
> @@ -540,7 +540,6 @@ int decode_negTokenInit(unsigned char *s
>  					   *(oid + 3)));
>  					rc = compare_oid(oid, oidlen, NTLMSSP_OID,
>  						 NTLMSSP_OID_LEN);
> -					if(oid)
>  						kfree(oid);
>  					if (rc)
>  						use_ntlmssp = TRUE;


Please fix the indentation of the kfree after removing the if.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

