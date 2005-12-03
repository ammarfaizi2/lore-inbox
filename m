Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVLCM2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVLCM2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVLCM2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:28:33 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:45977 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751232AbVLCM2c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:28:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jv3unHPSm9pfn78vphPTIcg0wavxxu6jIHRkkPsfD2AMRwVViyZVp1ErRE36ErSk5qqYaAJofxDCZ5neXwMG1P3uJJWygZovd7Fpncswj7DQCRpm03oGbXHYsj4wNuZBcK6C96r5peRATkDuVDE+4R1L2ckMNPORJkB0e1o3XQw=
Message-ID: <9a8748490512030428o55d9c8cfl112fadf8e8b7e02c@mail.gmail.com>
Date: Sat, 3 Dec 2005 13:28:31 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] fs/qnx4/bitmap.c: #if 0 qnx4_new_block()
Cc: al@alarsen.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051203121944.GC31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203121944.GC31395@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Adrian Bunk <bunk@stusta.de> wrote:
> qnx4_new_block() is neither implemented nor used.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.15-rc3-mm1/fs/qnx4/bitmap.c.old   2005-12-03 11:32:46.000000000 +0100
> +++ linux-2.6.15-rc3-mm1/fs/qnx4/bitmap.c       2005-12-03 11:33:07.000000000 +0100
> @@ -23,10 +23,12 @@
>  #include <linux/buffer_head.h>
>  #include <linux/bitops.h>
>
> +#if 0
>  int qnx4_new_block(struct super_block *sb)
>  {
>         return 0;
>  }
> +#endif  /*  0  */
>
>  static void count_bits(register const char *bmPart, register int size,
>                        int *const tf)
>

Adrian,
You submit a lot of nice patches, but your "#if 0" patches have always
puzzled me. Why is it that you prefer to use #if 0 to remove code
rather than simply delete it?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
