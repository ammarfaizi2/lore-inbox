Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbTJQNFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTJQNFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:05:11 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:24075 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S263456AbTJQNEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:04:46 -0400
Subject: Re: 2.6.0-test7-mm1
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: dev@sw.ru
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200310171258.11519.dev@sw.ru>
References: <20031015013649.4aebc910.akpm@osdl.org>
	 <1066232576.25102.1.camel@telecentrolivre>
	 <20031015165508.GA723@holomorphy.com>  <200310171258.11519.dev@sw.ru>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1066392124.13159.6.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 17 Oct 2003 10:02:05 -0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex, 2003-10-17 às 06:58, Kirill Korotaev escreveu:
> > Yup.  The "invalidate_inodes-speedup-fixes" and "invalidate_inodes-speedup"
> > patches were not so great and need to be reverted.
> I found another bug in invalidate_inodes-speedup.patch
> introduced by WLI when doing forward porting:
> 
> -			list_del(&inode->i_list);
> +			list_del(&inode->i_sb_list);
> 
> first list_del should be kept!!!

the fix for fs/inode.c solved the DEBUG_PAGEALLOC oops.

So, I think the invalidate_inodes-speedup.patch don't need to
be removed (but is good to keep it in next -mm, with the
new fix, of course :)).

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

