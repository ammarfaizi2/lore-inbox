Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbUATSWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUATSWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:22:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:61157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265646AbUATSWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:22:43 -0500
Date: Tue, 20 Jan 2004 10:23:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: GCS <gcs@lsc.hu>
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly network related
Message-Id: <20040120102302.47fa26cd.akpm@osdl.org>
In-Reply-To: <20040120175408.GA12805@lsc.hu>
References: <20040120000535.7fb8e683.akpm@osdl.org>
	<400D083F.6080907@aitel.hist.no>
	<20040120175408.GA12805@lsc.hu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCS <gcs@lsc.hu> wrote:
>
> Offtopic ps:Sorry that I can not help further now, I kicked a door too
>  badly that I think I broke my little finger on my leg. :-( But it would
>  worth to try without CONFIG_REGPARM as Helge noted he has it turned on,
>  and at least I also have it as Y.

CONFIG_REGPARM doesn't work on gcc-2.95 (at least), due to apparent
miscompilation or misdesign of strstr().  There are probably other such
issues.

So yes, whatever compiler you are using, turn off CONFIG_REGPARM - it is
still very experimental.

(And of dubious value - it only saved me 0.6% of program text).

