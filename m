Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWEHOz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWEHOz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWEHOz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:55:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27015 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932313AbWEHOz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:55:57 -0400
Subject: Re: High load average on disk I/O on 2.6.17-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Jason Schoonover <jasons@pioneer-pra.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <445F548A.703@mbligh.org>
References: <200605051010.19725.jasons@pioneer-pra.com>
	 <20060507095039.089ad37c.akpm@osdl.org>  <445F548A.703@mbligh.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 16:55:48 +0200
Message-Id: <1147100149.2888.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 07:24 -0700, Martin J. Bligh wrote:
> > It's pretty harmless though.  The "load average" thing just means that the
> > extra pdflush threads are twiddling thumbs waiting on some disk I/O -
> > they'll later exit and clean themselves up.  They won't be consuming
> > significant resources.
> 
> If they're waiting on disk I/O, they shouldn't be runnable, and thus
> should not be counted as part of the load average, surely?

yes they are, since at least a decade. "load average" != "cpu
utilisation" by any means. It's "tasks waiting for a hardware resource
to become available". CPU is one such resource (runnable) but disk is
another. There are more ... 

think of load as "if I bought faster hardware this would improve"


