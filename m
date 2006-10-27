Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752472AbWJ0VXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbWJ0VXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbWJ0VXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:23:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:55877 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752472AbWJ0VXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:23:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y16bHa3lS3Kz4pIt/OdxlKFrUjls/aNp2PONcpQQH5DvYrDu4TXO5gX0Q2JjvhzEoR65TA3mZ2YdsOj0H0/XvCa1KFCRGJe23fKnxi5VSKA70w+N+EdLAL0it7FJhG9UjcFq0Mhm6TRMy3UVRUJmrsMkpj9VoVXnemoNDT4VaNg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: tglx@linutronix.de
Subject: Re: [PATCH] silence 'make xmldocs' warning by adding missing description of 'raw' in nand_base.c:1485
Date: Fri, 27 Oct 2006 23:24:47 +0200
User-Agent: KMail/1.9.4
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Steven J.Hill" <sjhill@realitydiluted.com>,
       Linus Torvalds <torvalds@osdl.org>
References: <200610260143.24694.jesper.juhl@gmail.com> <1161840423.31783.29.camel@localhost.localdomain>
In-Reply-To: <1161840423.31783.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610272324.48087.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 October 2006 07:27, Thomas Gleixner wrote:
> On Thu, 2006-10-26 at 01:43 +0200, Jesper Juhl wrote:
> > 'make xmldocs' currently gives me this warning :
> > 
> >     Warning(/home/juhl/download/kernel/linux-2.6//drivers/mtd/nand/nand_base.c:1485): No description found for parameter 'raw'
> > 
> > This patch silences the warning by adding a description for 'raw'
> > 
> > 
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> 
> ACK
> 	tglx
> 
Thank you for the ACK Thomas.

Linus: Could you add this to your tree?  I believe it's still appropriate even at -rc3 since it doesn't make any code changes but simply fix an annoying warning.
Patch included (again) below for your convenience : 


Add description of 'raw' in comments for 
drivers/mtd/nand/nand_base.c::nand_write_page_syndrome() so 'make xmldocs' 
will not spew a warning at us.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/mtd/nand/nand_base.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index baece61..41bfcae 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1479,6 +1479,7 @@ static void nand_write_page_syndrome(str
  * @buf:	the data to write
  * @page:	page number to write
  * @cached:	cached programming
+ * @raw:	use _raw version of write_page
  */
 static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 			   const uint8_t *buf, int page, int cached, int raw)


