Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTGKQi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTGKQi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:38:26 -0400
Received: from intra.cyclades.com ([64.186.161.6]:34457 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264192AbTGKQiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:38:15 -0400
Message-ID: <013901c347cd$44586f60$602fa8c0@henrique>
From: "Henrique Oliveira" <henrique2.gobbi@cyclades.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Kevin Curtis" <kevin.curtis@farsite.co.uk>,
       "lkml" <linux-kernel@vger.kernel.org>
References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk> <Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva> <003101c34712$a9b8f480$602fa8c0@henrique> <1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
Date: Fri, 11 Jul 2003 09:55:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!!
No offence here but the generic hdlc layer's been always confusing. I will
write here what I believe is going on.
Until version 2.4.20 we had the old hdlc layer, with only one source file
hdlc.c. People that wanted to use the new hdlc layer had to apply a patch
provided by Halasa or by the WAN cards vendors. The kernel 2.4.21 came out
with the new hdlc layer, that includes a couple of files: hdlc_generic.c,
hdlc_fr.c, hdlc_ppp.c, hdlc_raw.c, etc. I don't know the status of the -ac
tree but I can say that the kernel 2.4.21 has the new code.
The new hdlc layer really needs new tools. This new tool can (supposedly) be
found at Halasa's web site. I don't know if someone has tested these tools
but I am about to run a test this afternoon. If someone is interested on the
results, just drop me a line.
regards
Henrique

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Henrique Oliveira" <henrique2.gobbi@cyclades.com>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>; "Kevin Curtis"
<kevin.curtis@farsite.co.uk>; "lkml" <linux-kernel@vger.kernel.org>
Sent: Friday, July 11, 2003 2:12 AM
Subject: Re: Why is generic hldc beig ignored? RE:Linux 2.4.22-pre4


> On Iau, 2003-07-10 at 19:39, Henrique Oliveira wrote:
> > Hi,
> > The patch for the generic HDLC layer was included on the kernel 2.4.21.
Thus
> > this layer is already on the main tree (unless, of course, someone has
> > removed it, I havent checked 2.4.22 yet). This layer provides data link
> > protocol (ppp, hdlc, raw-hdlc, x25, frame-relay, cisco-hdlc) for the
kernel.
> > It's mainly used by synchronous cards drivers (Cyclades, Moxa, SDL,
Farsite,
> > etc, etc, etc).
>
> 2.4.21 has much older code than the current stuff (which has been in -ac
> for a while). As I understand it the new hdlc layer needs newer tools ?

