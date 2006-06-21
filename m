Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWFUPIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWFUPIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWFUPIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:08:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:16776 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751649AbWFUPIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:08:51 -0400
Subject: Re: [PATCH 3/12] Add codes for additional ciphers
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Mike Halcrow <mike@halcrow.us>
In-Reply-To: <E1Fsngj-00078s-R0@localhost.localdomain>
References: <E1Fsngj-00078s-R0@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 10:08:49 -0500
Message-Id: <1150902529.24002.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> @@ -1018,10 +1018,14 @@ struct ecryptfs_cipher_code_str_map_elem
>  /* List in order of probability. */
>  static struct ecryptfs_cipher_code_str_map_elem
>  ecryptfs_cipher_code_str_map[] = {
> -	{"aes", 0x07},
> +	{"aes", 0x07}, /* AES-128 */
>  	{"blowfish", 0x04},
>  	{"des3_ede", 0x02},
> -	{"cast5", 0x03}
> +	{"cast5", 0x03},
> +	{"twofish", 0x0a},
> +	{"cast6", 0x0b},
> +	{"aes", 0x08}, /* AES-192 */
> +	{"aes", 0x09} /* AES-256 */
>  };

A ridiculously trivial suggestion here, but maybe just add the last
element of this table as such: {"aes", 0x09},... Not that it's overly
important, but it'll kill a couple unnecessary lines in the next patch
to this table.  Also, why not simply include the key-size in the name
(e.g. {"aes192", 0x08},}?  Granted, I haven't looked around at how this
string is being used in your code...

-tim

