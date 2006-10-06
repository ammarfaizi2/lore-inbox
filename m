Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWJFNJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWJFNJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWJFNJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:09:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:34234 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932287AbWJFNJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:09:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=YCgc8XBB+Ts9O+q8TctWO0Qgt7vDGd6Nj/2+wP5EDD5hyubl6pYpRzmApV6o/msH4TVl/tThvOclIkPRBVFYXICAlYPBPqKsLjtBFrCwL4sRkOORZgbs1FynEWmZ+WFNtiSyQBZpTehxRDPg0asUo+b/pvMJN15nAwH3s15Xwtg=
Message-ID: <452655E2.8090006@innova-card.com>
Date: Fri, 06 Oct 2006 15:10:58 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-kernel@vger.kernel.org,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 4/12] i386: define __pa_symbol()
References: <20061003170032.GA30036@in.ibm.com> <20061003171055.GD3164@in.ibm.com> <45237044.8090805@innova-card.com> <20061004194441.GF16218@in.ibm.com>
In-Reply-To: <20061004194441.GF16218@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

> +/* __pa_symbol should be used for C visible symbols.
> +   This seems to be the official gcc blessed way to do such arithmetic. */
> +#define __pa_symbol(x)          __pa(RELOC_HIDE((unsigned long)x,0))

#define __pa_symbol(x)          __pa(RELOC_HIDE((unsigned long)(x),0))
                                                               ^^^
... should be better. You should not rely on RELOC_HIDE implementation.

		Franck
