Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVIUTXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVIUTXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVIUTXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:23:04 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:47323 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751386AbVIUTXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:23:03 -0400
Date: Wed, 21 Sep 2005 15:23:01 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys
In-Reply-To: <12434.1127314090@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0509211520090.5265@excalibur.intercode>
References: <5378.1127211442@warthog.cambridge.redhat.com> 
 <12434.1127314090@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, David Howells wrote:


> +	if (is_key_possessed(key_ref)) {
> +		kperm = key->perm >> 24;
> +	}
> +	else if (key->uid == context->fsuid) {
>  		kperm = key->perm >> 16;

Can you use macros for these magic numbers?


- James
-- 
James Morris
<jmorris@namei.org>
