Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUERTsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUERTsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 15:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUERTsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 15:48:13 -0400
Received: from mail1.kontent.de ([81.88.34.36]:43981 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263126AbUERTsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 15:48:04 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: usb sleep patch
Date: Tue, 18 May 2004 21:46:54 +0200
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <40AA3A0E.5040500@pobox.com> <20040518171625.GB12348@kroah.com>
In-Reply-To: <20040518171625.GB12348@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405182146.54806.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> + * msleep - sleep safely even with waitqueue interruptions
> + * msecs: Time in milliseconds to sleep for
> + */
> +static inline void msleep(unsigned int msecs)

Why do you make it inline? After a milisecond the cache is cold,
so we should shrink the code.

	Regards
		Oliver
