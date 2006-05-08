Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWEHPbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWEHPbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWEHPbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:31:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49635 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932403AbWEHPbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:31:36 -0400
Subject: Re: High load average on disk I/O on 2.6.17-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060508152255.GF1875@harddisk-recovery.com>
References: <200605051010.19725.jasons@pioneer-pra.com>
	 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org>
	 <1147100149.2888.37.camel@laptopd505.fenrus.org>
	 <20060508152255.GF1875@harddisk-recovery.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 17:31:29 +0200
Message-Id: <1147102290.2888.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 17:22 +0200, Erik Mouw wrote:
> On Mon, May 08, 2006 at 04:55:48PM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-05-08 at 07:24 -0700, Martin J. Bligh wrote:
> > > > It's pretty harmless though.  The "load average" thing just means that the
> > > > extra pdflush threads are twiddling thumbs waiting on some disk I/O -
> > > > they'll later exit and clean themselves up.  They won't be consuming
> > > > significant resources.
> > > 
> > > If they're waiting on disk I/O, they shouldn't be runnable, and thus
> > > should not be counted as part of the load average, surely?
> > 
> > yes they are, since at least a decade. "load average" != "cpu
> > utilisation" by any means. It's "tasks waiting for a hardware resource
> > to become available". CPU is one such resource (runnable) but disk is
> > another. There are more ... 
> 
> ... except that any kernel < 2.6 didn't account tasks waiting for disk
> IO.

they did. It was "D" state, which counted into load average.



