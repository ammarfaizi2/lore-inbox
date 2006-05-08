Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWEHLWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWEHLWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 07:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWEHLWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 07:22:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6056 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751258AbWEHLWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 07:22:48 -0400
Subject: Re: High load average on disk I/O on 2.6.17-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Andrew Morton <akpm@osdl.org>, Jason Schoonover <jasons@pioneer-pra.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060508111345.GA1875@harddisk-recovery.com>
References: <200605051010.19725.jasons@pioneer-pra.com>
	 <20060507095039.089ad37c.akpm@osdl.org>
	 <20060508111345.GA1875@harddisk-recovery.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:22:36 +0200
Message-Id: <1147087356.2888.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 13:13 +0200, Erik Mouw wrote:
> On Sun, May 07, 2006 at 09:50:39AM -0700, Andrew Morton wrote:
> > This is probably because the number of pdflush threads slowly grows to its
> > maximum.  This is bogus, and we seem to have broken it sometime in the past
> > few releases.  I need to find a few quality hours to get in there and fix
> > it, but they're rare :(
> > 
> > It's pretty harmless though.  The "load average" thing just means that the
> > extra pdflush threads are twiddling thumbs waiting on some disk I/O -
> > they'll later exit and clean themselves up.  They won't be consuming
> > significant resources.
> 
> Not completely harmless. Some daemons (sendmail, exim) use the load
> average to decide if they will allow more work.

and those need to be fixed most likely ;)


