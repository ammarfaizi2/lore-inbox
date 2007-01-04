Return-Path: <linux-kernel-owner+w=401wt.eu-S932335AbXADIxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbXADIxQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 03:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbXADIxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 03:53:16 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:40963 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbXADIxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 03:53:15 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 4 Jan 2007 03:48:20 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Thomas Hisch <t.hisch@gmail.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Simplify some code to use the container_of() macro.
In-Reply-To: <20070104084224.GA3630@unknown-00-0d-60-79-ca-00.lan>
Message-ID: <Pine.LNX.4.64.0701040347360.5101@localhost.localdomain>
References: <Pine.LNX.4.64.0612311547200.30821@localhost.localdomain>
 <20070104084224.GA3630@unknown-00-0d-60-79-ca-00.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Thomas Hisch wrote:

> On Sun, Dec 31, 2006 at 03:55:22PM -0500, Robert P. J. Day wrote:
> > @@ -1810,8 +1809,7 @@ lcs_get_frames_cb(struct lcs_channel *channel, struct lcs_buffer *buffer)
> >  		LCS_DBF_TEXT(4, trace, "-eiogpkt");
> >  		return;
> >  	}
> > -	card = (struct lcs_card *)
> > -		((char *) channel - offsetof(struct lcs_card, read));
> > +	card = container_of(channel, struct lcs_card, write);
> the last argument in container_of should be read instead of write.

gack, i really made a mess of that one, didn't i?  sorry, i'll send
andrew a revised and healthy patch.

rday
