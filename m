Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBIUVl>; Fri, 9 Feb 2001 15:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129176AbRBIUVb>; Fri, 9 Feb 2001 15:21:31 -0500
Received: from cs.columbia.edu ([128.59.16.20]:33451 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129032AbRBIUVV>;
	Fri, 9 Feb 2001 15:21:21 -0500
Date: Fri, 9 Feb 2001 12:21:17 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
        <jes@linuxcare.com>, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <3A844EDB.7F1CA6BE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0102091213250.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Jeff Garzik wrote:

> For 2.2, define SET_MODULE_OWNER to null.
> 
> Define STAR_MOD_INC_USE_COUNT and STAR_MOD_DEC_USE_COUNT.  For 2.4,
> these are null.  For 2.2, these point to MOD_{INC,DEC}_USE_COUNT.

... and use both SET_MODULE_OWNER and STAR_MOD_*_USE_COUNT. It's along the 
lines of what I was thinking -- though I don't think it's very clean.

Thanks a lot for the suggestion.

And one more question: is 2.2.x compatibility stuff acceptable in a 2.4 
driver, given that all that stuff is in *one* #ifdef and not sprinkled 
throughout the file?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
