Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWDULxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWDULxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWDULxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:53:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:57476 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751294AbWDULxu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:53:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oxKFAsY0DwN5YQfJWJFxpCBh+911nbtR6RzJ685lQFSAMRumtv+F2210CR1UxoeqKKNFXwcpV8wCuYNa7itzxqRPxx731caXnKwP0IXx4UwC/ABfU4TNM4dEtZ+3lvSRjeEqcYlOKjJsw8krcoSSbfFl2RbXzJ3or5dE8Qa0yVQ=
Message-ID: <84144f020604210453w186f20a4s3d163c395364e87e@mail.gmail.com>
Date: Fri, 21 Apr 2006 14:53:48 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Michael Holzheu" <holzheu@de.ibm.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20060421133541.37002378.holzheu@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060421133541.37002378.holzheu@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 4/21/06, Michael Holzheu <holzheu@de.ibm.com> wrote:
> On zSeries machines there exists an interface which allows the operating
> system  to retrieve LPAR hypervisor accounting data.

[snip]

>  fs/Kconfig            |   11
>  fs/Makefile           |    1
>  fs/hypfs/Makefile     |    7
>  fs/hypfs/hypfs.h      |   43 +++
>  fs/hypfs/hypfs_diag.c |  628 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/hypfs/hypfs_diag.h |   16 +
>  fs/hypfs/inode.c      |  469 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 1175 insertions(+)

This filesystem makes no sense for anything but s390 so please put it
under arch/s390/ (following the convention set by cell specific
spufs). Thanks.

                                         Pekka
