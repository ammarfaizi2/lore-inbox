Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKCXmB>; Fri, 3 Nov 2000 18:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKCXlw>; Fri, 3 Nov 2000 18:41:52 -0500
Received: from Cantor.suse.de ([194.112.123.193]:13585 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129033AbQKCXlc>;
	Fri, 3 Nov 2000 18:41:32 -0500
Date: Sat, 4 Nov 2000 00:41:29 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>, kuznet@ms2.inr.ac.ru,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        davies@maniac.ultranet.com
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
Message-ID: <20001104004129.C5173@gruyere.muc.suse.de>
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> <200011031937.WAA10753@ms2.inr.ac.ru> <20001103160108.D16644@ganymede.isdn.uiuc.edu> <3A033C82.114016A0@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A033C82.114016A0@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 03, 2000 at 05:30:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 05:30:26PM -0500, Jeff Garzik wrote:
> Bill Wendling wrote:
> > 
> > Also sprach kuznet@ms2.inr.ac.ru:
> > } > de4x5 is probably also buggy in regard to this.
> > }
> > } de4x5 is hopeless. I added nice comment in softnet to it.
> > } Unfortunately it was lost. 8)
> > }
> > } Andi, neither you nor me nor Alan nor anyone are able to audit
> > } all this unnevessarily overcomplicated code. It was buggy, is buggy
> > } and will be buggy. It is inavoidable, as soon as you have hundreds
> > } of drivers.
> > }
> > If they are buggy and unsupported, why aren't they being expunged from
> > the main source tree and placed into a ``contrib'' directory or something
> > for people who may want those drivers?
> 
> de4x5 is stable.  Its hopeless to add stuff to it, or try to any fix of
> the (IMHO small) issues, but its fine as is.  For maintenance issues,
> its PCI support will be eliminated in 2.5.x because it is a duplicate of
> support in the tulip driver.

de4x5 is stable, but tends to perform badly under load, mostly because
it doesn't use rx_copybreak and overflows standard socket buffers with its
always MTU sized skbuffs.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
