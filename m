Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbRFMNtK>; Wed, 13 Jun 2001 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbRFMNtB>; Wed, 13 Jun 2001 09:49:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45779 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262686AbRFMNst>;
	Wed, 13 Jun 2001 09:48:49 -0400
Message-ID: <3B276F31.8BBF06AF@mandrakesoft.com>
Date: Wed, 13 Jun 2001 09:48:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
In-Reply-To: <8272.992434020@ocs4.ocs-net> <15143.22734.747077.588558@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Keith Owens writes:
>  > do_softirq is called from asm code which does not get preprocessed.
>  > It needs to be exported with no version.
> 
> It can get preprocessed if you know how.  Simply use the "i" asm
> constraint for an extra argument, and use the symbol there.  For
> example:
> 
>         __asm__("%0" : : "i" (my_versioned_symbol));
> 
> It works and we've been doing it on sparc for ages.

how to do this in foo.S code?

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
