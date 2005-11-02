Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVKBGem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVKBGem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVKBGem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:34:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932451AbVKBGem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:34:42 -0500
Date: Wed, 2 Nov 2005 16:34:23 +1100
From: Andrew Morton <akpm@osdl.org>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-Id: <20051102163423.460fe9c5.akpm@osdl.org>
In-Reply-To: <436776C6.3040900@free.fr>
References: <4363F9B5.6010907@free.fr>
	<20051031155803.2e94069f.akpm@osdl.org>
	<436776C6.3040900@free.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet <castet.matthieu@free.fr> wrote:
>
> >>+
>  >>+	*cmvs = (struct uea_cmvs *)(data + 1);
>  > 
>  > 
>  > That's a bit rude - asking the compiler to perform a structure copy from an
>  > odd address.  memcpy() would be saner.
>  > 
>  Could you elaborate a bit more ?
>  I don't see where there is a copy.
>  *cmvs is a pointer to the structure, not the structure. And when we 
>  parse the structure, we use get_unaligned functions.
> 
> 

Ah, I misread the code.
