Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRKMTLC>; Tue, 13 Nov 2001 14:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278364AbRKMTKw>; Tue, 13 Nov 2001 14:10:52 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:2553 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278313AbRKMTKl>;
	Tue, 13 Nov 2001 14:10:41 -0500
Date: Tue, 13 Nov 2001 12:10:22 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
Message-ID: <20011113121022.L1778@lynx.no>
Mail-Followup-To: Benjamin LaHaise <bcrl@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011112232539.A14409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011112232539.A14409@redhat.com>; from bcrl@redhat.com on Mon, Nov 12, 2001 at 11:25:39PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 12, 2001  23:25 -0500, Benjamin LaHaise wrote:
> Please incorporate this patch to make mtrr.c conform to the standards set 
> forth in Documentation/CodingStyle which make it much more appealing to 
> the eyes.
>
>  /*  Put the processor into a state where MTRRs can be safely set  */
> -static void set_mtrr_prepare (struct set_mtrr_context *ctxt)
> +static void
> +set_mtrr_prepare(struct set_mtrr_context *ctxt)
>  {

Is that actually CodingStyle?  Don't see it much in the kernel code...
The much more common (AFAICS) style to split long function definitions is

static void foo_long_function(struct long_struct name *foo, struct bar *bar,
                              int val, long *err)

The only reason (AFAICS) for putting the return type on a separate line
is the (ancient) ansi2knr script, which just throws the return types away
for pre-ANSI compilers.  Given that the kernel code doesn't even conform
to ANSI-C, there is no hope in hell of it compiling with a pre-ANSI compiler.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

