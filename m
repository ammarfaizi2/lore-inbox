Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUBWPgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbUBWPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:36:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63915 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261936AbUBWPgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:36:48 -0500
Date: Mon, 23 Feb 2004 10:36:57 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: Fruhwirth Clemens <clemens-dated-1078360505.b6b1@endorphin.org>,
       Christophe Saout <christophe@saout.de>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <20040223134403.GA22682@certainkey.com>
Message-ID: <Xine.LNX.4.44.0402231036210.19700-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Jean-Luc Cooke wrote:

> The analogy of:
> 
> for (i=0; i<len; i++)
>   omac_encrypt(tfm, dst[i], src[i], nbytes);
> 
> Will not work with OMAC since it creates a MAC and not a ciphertext stream
> like the other modes.
> 
> for (i=0; i<len; i++)
>   omac_encrypt(tfm, dst[0], src[i], nbytes);
> /*                      ^ see here!           */
> memcpy(mac, dest, ...); /* store the mac */
> 
> Is more appropriate.  James - is this possible?

What exactly are you trying to do?


- James
-- 
James Morris
<jmorris@redhat.com>


