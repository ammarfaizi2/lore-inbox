Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUIOVbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUIOVbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267557AbUIOV1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:27:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:27305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267438AbUIOVYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:24:55 -0400
Date: Wed, 15 Sep 2004 14:28:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][5/6]ELF format dump file access
Message-Id: <20040915142839.4bc6c167.akpm@osdl.org>
In-Reply-To: <20040915125631.GF15450@in.ibm.com>
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
	<20040915125422.GD15450@in.ibm.com>
	<20040915125525.GE15450@in.ibm.com>
	<20040915125631.GF15450@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
>
> -static int notesize(struct memelfnote *en)
> +int notesize(struct memelfnote *en)
>  {
>  	int sz;
>  
> @@ -129,7 +129,7 @@ static int notesize(struct memelfnote *e
>  /*
>   * store a note in the header buffer
>   */
> -static char *storenote(struct memelfnote *men, char *bufp)
> +char *storenote(struct memelfnote *men, char *bufp)

As you're giving these kernel-wide scope, please also rename them
to elf_notesize() and elf_storenote().
