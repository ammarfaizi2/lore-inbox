Return-Path: <linux-kernel-owner+w=401wt.eu-S1761264AbWLINxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761264AbWLINxs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761333AbWLINxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:53:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:26134 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761264AbWLINxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:53:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nq9SvFNgfSLmygVf0L8qa+d47EB95k6kqaoTpnOTgzkbBrk+fyiOopDcxkR9oceUmv/wL4t6uaAglGD+AulzjEtoukb3W039blMEQ7yMk7moQOhqzrFOmQz0mIREjQ9TEORvvog0DTupC5PdRcpHXv8StuUBOQV7mDZdSo79gGg=
Message-ID: <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
Date: Sat, 9 Dec 2006 15:53:45 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to kcalloc().
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
X-Google-Sender-Auth: 0b47c68bb1e5b534
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> @@ -705,7 +705,7 @@ static int uss720_probe(struct usb_inter
>         /*
>          * Allocate parport interface
>          */
> -       if (!(priv = kcalloc(sizeof(struct parport_uss720_private), 1, GFP_KERNEL))) {
> +       if (!(priv = kcalloc(1, sizeof(struct parport_uss720_private), GFP_KERNEL))) {

This one should be kzalloc

You really ought to send these cleanups to akpm@osdl.org with LKML
cc'd to get them merged.
