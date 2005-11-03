Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVKCX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVKCX7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVKCX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:59:41 -0500
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:1923 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932644AbVKCX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:59:40 -0500
Date: Thu, 3 Nov 2005 18:59:42 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Phillip Hellewell <phillip@hellewell.homeip.net>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 11/12: eCryptfs] Keystore
In-Reply-To: <20051103035611.GK3005@sshock.rn.byu.edu>
Message-ID: <Pine.LNX.4.63.0511031856050.22256@excalibur.intercode>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035611.GK3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Phillip Hellewell wrote:

> +	password_s_ptr = &auth_tok->token.password;
> +	if (password_s_ptr->session_key_encryption_key_set) {
> +		ecryptfs_printk(1, KERN_NOTICE, "Session key encryption key "
> +				"set; skipping key generation\n");
> +		goto session_key_encryption_key_set;
> +	}
> +      session_key_encryption_key_set:
> +	ecryptfs_printk(1, KERN_NOTICE, "Session key encryption key (size [%d])"
> +			":\n", password_s_ptr->session_key_encryption_key_size);

Spurious goto?

> +out:
> +	if (tfm)
> +		crypto_free_tfm(tfm);
> +	return rc;

Just call crypto_free_tfm() unconditionally.


- James
-- 
James Morris
<jmorris@namei.org>
