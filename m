Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWAXLIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWAXLIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 06:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWAXLIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 06:08:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35752 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030437AbWAXLIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 06:08:45 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11380489522073@2gen.com> 
References: <11380489522073@2gen.com> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 04/04] Add dsa key type 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 24 Jan 2006 11:08:45 +0000
Message-ID: <17755.1138100925@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman <david@2gen.com> wrote:

> Adds the dsa in-kernel key type.

Please add a header file in include/keys/ to provide access to the key type
definition and any special payload structures you use.

> +static char *
> +sign(const struct key_payload_dsa *skey, 

Please be consistent about sticking prefixes on the names of your
functions. This ought to be called something like dsa_sign.

> +		printk("dsa: crypto_digest_setkey failed with error %i\n", i);

Should involve KERN_ERR or something like.

David
