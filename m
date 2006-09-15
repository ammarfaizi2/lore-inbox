Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWIOSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWIOSVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWIOSVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:21:17 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:47263 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932124AbWIOSVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:21:16 -0400
Subject: Re: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Marcel Siegert <mws@linuxtv.org>
In-Reply-To: <450AEBFD.2070106@linuxtv.org>
References: <20060906224631.999046890@quad.kroah.org>
	 <20060906225740.GD15922@kroah.com> <45016909.4080908@linuxtv.org>
	 <20060908172944.GA1254@suse.de>  <450AD0CA.7080800@linuxtv.org>
	 <1158338161.5233.47.camel@localhost>  <450AEBFD.2070106@linuxtv.org>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 20:18:23 +0200
Message-Id: <1158344303.5233.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> >>>> Can we hold off on this until the 2.6.17.13 review cycle?  This patch
> >>>> has not been sent to the linux-dvb mailing list, it has not been
> >>>> reviewed or tested except for the Author and Marcel.
> >>> Yes, I've now moved it, thanks.
> >> Marcel Siegert and I spoke about this today --  We are doing things a
> >> bit differently for 2.6.18 and later, but this patch is appropriate for
> >> 2.6.17.y
> > 
> > so this means it is fixed in 2.6.18 or is it still vulnerable. If it is
> > still vulnerable, then we need a fix. And we need it now.
> 
> 2.6.18 should not be vulnerable.  See the following changeset in Linus'
> tree:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=8859ab74f0fe4c65c8e75b9350a2a0b138615525;hp=9fd87521a1639bd3dae51dcdce48545614d41a85;hb=18232ca61b4c73b849850200a5e6ec40517f35ab;f=drivers/media/dvb/dvb-core/dvb_net.c
> 
> Quoting MWS from irc:
> 
> if the len is smaller than 4 or if dbit set smaller than 4+ealen, just
> get rid of that packet and interpret as error. the 2.6.18 is not letting
> them through if they are < sizeof(5), so 4 byte packets would be ignored.

I saw the changeset in the current 2.6.18-rc kernel and this was the
reason for me asking. I don't have the hardware to reproduce this, but
if you say that the final 2.6.18 kernel will not be vulnerable, then I
take your word for it.

Regards

Marcel


