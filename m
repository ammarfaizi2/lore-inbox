Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWGTRtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWGTRtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWGTRtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:49:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:43828 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750825AbWGTRtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:49:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FK6rkbMIAChhJaKwgZCTUqVXSqI2TSa2TaonIhlzYzUJbL+Y8+p4D5BftBzoS2uZXqRTxLVIZIoPjzud2UzMHuL96iRZrOCh/tq6bN04njQlIPuZaSTvEOl6d50fRObPs9CGJryNU9UWg9JXUCJZ6OJlEm4dxy2sBLIldHQ10IU=
Message-ID: <84144f020607201049g1391d3f4qfdb6f4a0821a5be8@mail.gmail.com>
Date: Thu, 20 Jul 2006 20:49:08 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Panagiotis Issaris" <takis@gna.org>
Subject: Re: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: "Daniel K." <daniel@cluded.net>,
       "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <1153416317.11873.22.camel@hemera>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060719004659.GA30823@lumumba.uhasselt.be>
	 <44BD9BA8.7070202@cluded.net> <1153416317.11873.22.camel@hemera>
X-Google-Sender-Auth: 19347a9255b877ae
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Panagiotis Issaris <takis@gna.org> wrote:
> I figured someone might want to add extra code in f.e. RIOGetCmddBlk to
> be able to debug/modify memory allocation behavior for the RIO driver
> only. It does look a bit messy though. So I've updated it in my updated
> patch.

Yes, we have people adding those and I keep trying to get rid of them
;-). With Al Viro's slab memory leak tracking patches in-tree and
Catalin's kmemleak on the way, there really is no excuse adding new
ones.
