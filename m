Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWBOWfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWBOWfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBOWfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:35:39 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:20923 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751300AbWBOWfi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:35:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ID2hM4wZ9m3K0tpxDlISmGkLV4ygoqxuW3tlUCTSlWjTo1dN0cakbXM66DS4RtJEg9tWRIT2FTrl8h84NJZ0zoWPLJ9PqRbyb1AJbPhmufwMvslEGx9DCO4/eJXn98ftEZTiV209V3MniKuID0EsWAERxi+TkB1CxYV39qzvO/Y=
Message-ID: <39e6f6c70602151435r5b965670oab580c75bbaee7ab@mail.gmail.com>
Date: Wed, 15 Feb 2006 20:35:37 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: spereira@tusc.com.au
Subject: Re: [PATCH 5/6] x25: Allow 32 bit socket ioctl in 64 bit kernel
Cc: netdev <netdev@vger.kernel.org>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>,
       "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
       Andre Hendry <ahendry@tusc.com.au>
In-Reply-To: <1140042162.8745.30.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140042162.8745.30.camel@spereira05.tusc.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/06, Shaun Pereira <spereira@tusc.com.au> wrote:

> +               switch (*p) {
> +                       case X25_FAC_CALLING_AE:
> +                               if (p[1] > 33)
> +                               break;
> +                               dte_facs->calling_len = p[2];
> +                               memcpy(dte_facs->calling_ae, &p[3], p[1] - 1);
> +                               *vc_fac_mask |= X25_MASK_CALLING_AE;
> +                               break;

Can this '33' magic number be replaced with a define or sizeof(something)?

- Arnaldo
