Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWJBUKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWJBUKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWJBUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:10:20 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:44429 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964949AbWJBUKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tLbfbzoiQjVOyZXuxTFVFdhLyfZIZasZXud7RnnU3s9KggvDnBUqGDtNRPd9W+POXwbVOnyv59nqkTYCOiH+YzpuM2/EifuXoY+BdH3mA0wB4Re+sF81bv/bGTv2/0YeurIcOQ08tsEu6RWgHKeK/oJfZiOC/SBYyIqbTsdbac4=  ;
From: David Brownell <david-b@pacbell.net>
To: "Thiago Galesi" <thiagogalesi@gmail.com>
Subject: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Date: Mon, 2 Oct 2006 13:10:14 -0700
User-Agent: KMail/1.7.1
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Andrea Paterniani" <a.paterniani@swapp-eng.it>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <200610020816.58985.david-b@pacbell.net> <82ecf08e0610021137r446031a8pa303053479e9cb27@mail.gmail.com>
In-Reply-To: <82ecf08e0610021137r446031a8pa303053479e9cb27@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021310.15374.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 11:37 am, Thiago Galesi wrote:
> <nitpickery on>

Similarly: the TO: should be "Andrea Paterniani" <a.paterniani@swapp-eng.it>.  :)


> > +/*-------------------------------------------------------------------------*/
> > +/* SPI Control Register Bit Fields & Masks */
> > +#define SPI_CONTROL_BITCOUNT   (0xF)           /* Bit Count Mask */
> > +#define SPI_CONTROL_BITCOUNT_1 (0x0)           /* Bit Count = 1 */
> > +#define SPI_CONTROL_BITCOUNT_2 (0x1)           /* Bit Count = 2 */
> > +#define SPI_CONTROL_BITCOUNT_3 (0x2)           /* Bit Count = 3 */
> 
> I thinking these comments are awfully confusing (bitcount_1 == 0
> ?!?!?) and maybe redundant.

Those parentheses are redundant too ... :)


> It would be much more useful to explain the logic behind why
> (bitcount_1 == 0) and remove the /* Bit Count = X */ comments
> 
> 
> > +/* SPI Soft Reset Register Bit Fields & Masks */
> > +#define SPI_RESET_START                (0x1 << 0)      /* Start */
> 
> Wouldn't only (0x1) be better?
> 
> > +
> > +/* Message state */
> > +#define START_STATE                    ((void*)0)
> > +#define RUNNING_STATE                  ((void*)1)
> > +#define DONE_STATE                     ((void*)2)
> > +#define ERROR_STATE                    ((void*)-1)
> 
> !?!??!?!

Now that you mention it ... let me second that comment!

I guess that in the middle of reviewing ~250K lines of new driver,
it's perhaps too easy to overlook wierdness with constants.

- Dave

> All in all, except for what Andrew has pointed out, it looks good,
> maybe a little bit overengineered...
> 
> -- 
> -
> Thiago Galesi
> 
