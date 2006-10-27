Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWJ0XZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWJ0XZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWJ0XZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:25:50 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:51406 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750843AbWJ0XZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:25:50 -0400
Date: Fri, 27 Oct 2006 16:21:16 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jesper.juhl@gmail.com, torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] silence 'make xmldocs' warning by adding missing
 description of 'raw' in nand_base.c:1485
Message-Id: <20061027162116.deb9dafe.randy.dunlap@oracle.com>
In-Reply-To: <200610272259.k9RMx3cq030980@hera.kernel.org>
References: <200610272259.k9RMx3cq030980@hera.kernel.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 22:59:03 GMT Linux Kernel Mailing List wrote:

> commit efbfe96c5d839c367249bf1cd53249716450c0a2
> tree 36a1a7d72586a2f8fd25feb225cd4e627cd275b3
> parent 735a7ffb739b6efeaeb1e720306ba308eaaeb20e
> author Jesper Juhl <jesper.juhl@gmail.com> 1161984287 +0200
> committer Linus Torvalds <torvalds@g5.osdl.org> 1161988491 -0700
> 
> [PATCH] silence 'make xmldocs' warning by adding missing description of 'raw' in nand_base.c:1485
> 
> Add description of 'raw' in comments for
> drivers/mtd/nand/nand_base.c::nand_write_page_syndrome() so 'make xmldocs'
> will not spew a warning at us.
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/mtd/nand/nand_base.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index baece61..41bfcae 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -1479,6 +1479,7 @@ static void nand_write_page_syndrome(str
>   * @buf:	the data to write
>   * @page:	page number to write
>   * @cached:	cached programming
> + * @raw:	use _raw version of write_page
>   */
>  static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
>  			   const uint8_t *buf, int page, int cached, int raw)
> -

Hi Jesper,
I'm still seeing a kernel-doc warning in include/linux/mtd/nand.h.
Do you not see it also?

Patch is here:
http://marc.theaimsgroup.com/?l=linux-mm-commits&m=116189778426861&w=2

---
~Randy
