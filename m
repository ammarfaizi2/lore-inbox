Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWAWA67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWAWA67 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAWA67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:58:59 -0500
Received: from audible.transient.net ([216.254.12.79]:36320 "HELO
	audible.transient.net") by vger.kernel.org with SMTP
	id S932414AbWAWA66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:58:58 -0500
Date: Sun, 22 Jan 2006 16:58:56 -0800
From: Jamie Heilman <jamie@audible.transient.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Message-ID: <20060123005856.GB15490@fifty-fifty.audible.transient.net>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <1137917798.3328.2.camel@laptopd505.fenrus.org> <1137918044.3328.6.camel@laptopd505.fenrus.org> <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz> <1137956841.3328.36.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137956841.3328.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2006-01-22 at 13:51 -0500, Ariel wrote:
> > On Sun, 22 Jan 2006, Arjan van de Ven wrote:
> > 
> > > On Sun, 2006-01-22 at 09:16 +0100, Arjan van de Ven wrote:
> > >> On Sat, 2006-01-21 at 21:13 -0500, Ariel wrote:
> > >>> I have a memory leak in scsi_cmd_cache.
> > 
> > >> does this happen without the binary nvidia driver too? (it appears
> > >> you're using that). That's a good datapoint to have if so...
> > 
> > I had the exact same nvidia driver with 2.6.12 (just recompiled) and it 
> > didn't happen there.
> > 
> > But just in case I used slabtop to watch scsi_cmd_cache grow by 1.24KB per 
> > second (104MB per day), then I rmmoded nvidia and watched it grow by 
> > 1.16KB per 
> 
> please repeat this without nvidia ever being loaded. Just having a
> module loaded before can already cause corruption that ripples through
> later, so just unloading is not enough to get a clean result.

Hrmph, yeah one of my workstations is exhibiting this too.  I use
the nvidia module, but I did clean reboot without it loaded and the
leak was still there.  So I'll add my data points at
http://audible.transient.net/~jamie/k/ ... all the files starting with
"scsi_cmd_cache."

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
