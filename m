Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278216AbRJRXu1>; Thu, 18 Oct 2001 19:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278218AbRJRXuR>; Thu, 18 Oct 2001 19:50:17 -0400
Received: from palrel11.hp.com ([156.153.255.246]:46346 "HELO palrel11.hp.com")
	by vger.kernel.org with SMTP id <S278216AbRJRXuJ>;
	Thu, 18 Oct 2001 19:50:09 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D581@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'David S. Miller'" <davem@redhat.com>,
        "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: RE: Problem with 2.4.14prex and qlogicfc
Date: Thu, 18 Oct 2001 16:50:28 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

This appears to clear up the problems that I was having.  I'm running
numbers now and will let you know how it goes.

Thanks,
Cary

> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: Thursday, October 18, 2001 6:25 AM
> To: cary_dickens2@hp.com
> Cc: axboe@suse.de; linux-kernel@vger.kernel.org; erik_habbinga@hp.com
> Subject: Re: Problem with 2.4.14prex and qlogicfc
> 
> 
> 
> Please try this patch:
> 
> --- linux/drivers/scsi/qlogicfc.h.~1~	Tue Nov 28 08:33:08 2000
> +++ linux/drivers/scsi/qlogicfc.h	Thu Oct 18 05:22:52 2001
> @@ -62,13 +62,8 @@
>   * determined for each queue request anew.
>   */
>  
> -#if BITS_PER_LONG > 32
>  #define DATASEGS_PER_COMMAND 2
>  #define DATASEGS_PER_CONT 5
> -#else
> -#define DATASEGS_PER_COMMAND 3
> -#define DATASEGS_PER_CONT 7
> -#endif
>  
>  #define QLOGICFC_REQ_QUEUE_LEN	127	/* must be 
> power of two - 1 */
>  #define QLOGICFC_MAX_SG(ql)	(DATASEGS_PER_COMMAND + (((ql) 
> > 0) ? DATASEGS_PER_CONT*((ql) - 1) : 0))
> 
