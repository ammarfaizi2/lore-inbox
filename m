Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWIEVIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWIEVIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWIEVIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:08:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60358 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422635AbWIEVIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:08:44 -0400
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible
	recursive	locking detected
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <44FDCEAD.5070905@s5r6.in-berlin.de>
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
	 <20060905111306.80398394.akpm@osdl.org>
	 <44FDCEAD.5070905@s5r6.in-berlin.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 05 Sep 2006 23:07:59 +0200
Message-Id: <1157490479.28193.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 21:23 +0200, Stefan Richter wrote:
> Andrew Morton wrote:
> > On Tue, 5 Sep 2006 10:37:51 -0700
> > "Miles Lane" <miles.lane@gmail.com> wrote:
> > 
> >> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> >> ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> >> ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]
> >>
> >> =============================================
> >> [ INFO: possible recursive locking detected ]
> >> 2.6.18-rc5-mm1 #2
> >> ---------------------------------------------
> >> knodemgrd_0/2321 is trying to acquire lock:
> >>  (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >>
> >> but task is already holding lock:
> >>  (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]
> [...]
> 
> This information confuses me. These places are not supposed to be the
> ones where the locks were actually acquired, are they?

they should be yes
(but inlined functions get the name of the function they are inlined
into)



