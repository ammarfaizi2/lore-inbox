Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbTFMP3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265414AbTFMP3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:29:19 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:26633 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S265413AbTFMP3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:29:18 -0400
Date: Sat, 14 Jun 2003 01:42:57 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Frank Cusack <fcusack@fcusack.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cryptoapi 2.5->2.4 backport
In-Reply-To: <20030613035845.A27655@google.com>
Message-ID: <Mutt.LNX.4.44.0306140139530.26147-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Frank Cusack wrote:

> Any problem with just changing crypto/cipher.c:
> 
>     enum km_type crypto_km_types[] = {
>             KM_USER0,
>             KM_USER1,
>             KM_SOFTIRQ0,
>             KM_SOFTIRQ1,
>     };
> 
> to
> 
>     enum km_type crypto_km_types[] = {
>             KM_USER0,
>             KM_USER1,
>             KM_USER0,
>             KM_USER1,
>     };
> 
> ?

Yes, the crypto calls can run in user and softirq context.

Which backport is this?


- James
-- 
James Morris
<jmorris@intercode.com.au>

