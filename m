Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbUL0VMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbUL0VMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbUL0VMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:12:53 -0500
Received: from pils.us-lot.org ([212.67.207.13]:58376 "EHLO pils.us-lot.org")
	by vger.kernel.org with ESMTP id S261985AbUL0VMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:12:49 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: (Discussion) Stop IDE legacy ISA probes on PCI systems
References: <1104156823.20898.21.camel@localhost.localdomain>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Mon, 27 Dec 2004 21:15:26 +0000
In-Reply-To: <1104156823.20898.21.camel@localhost.localdomain> (Alan Cox's
 message of "Mon, 27 Dec 2004 14:13:45 +0000")
Message-ID: <y2a7jn34f4h.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>  	switch (index) {
>  		case 0:	return 0x1f0;
>  		case 1:	return 0x170;
> +		
> +		if(pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
> +			case 2: return 0x1e8;
> +			case 3: return 0x168;
> +			case 4: return 0x1e0;
> +			case 5: return 0x160;
> +		}
> +
>  		default:
>  			return 0;
>  	}

I don't think that code will have the intended effect, unless your
GCC has some funny ideas about switch statements...

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
