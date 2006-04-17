Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWDQRId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWDQRId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDQRId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:08:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38056 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751165AbWDQRIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:08:32 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Christoph Hellwig <hch@infradead.org>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
	 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 19:08:26 +0200
Message-Id: <1145293707.2847.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 13:03 -0400, Stephen Smalley wrote:
> On Mon, 2006-04-17 at 17:23 +0100, Christoph Hellwig wrote:
> > On Mon, Apr 17, 2006 at 12:06:53PM -0400, Stephen Smalley wrote:
> > > > I thought of this, see label_all_processes. Unfortunately I found no way of 
> > > > actually doing this. I would need to iterate through the tasklist structure, 
> > > > but the task_lock export is going to be removed from the kernel.
> > > 
> > > So, if built-in isn't an option, propose an interface to the core
> > > security framework to allow security modules to perform such
> > > initialization without needing to directly touch the lock themselves
> > 
> > NACK.  The whole idea of loading security modules after bootup is flawed.
> > Any scheme that tries to enumerate process and other entinity after the
> > fact for access control purposes is fundamentally flawed.  We're not going
> > to add helpers or exports for it, I'd rather remove the ability to build
> > lsm hook clients modular completely.
> 
> Or, better, remove LSM itself ;)
> 

at minimum I can see the point to make the lsm hooks compile directly to
the selinux functions in question when selinux is the security module of
choice; that'll save quite a bit of performance already


