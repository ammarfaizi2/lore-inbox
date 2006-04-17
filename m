Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWDQQ7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWDQQ7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWDQQ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:59:22 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:48614 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751157AbWDQQ7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:59:21 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christoph Hellwig <hch@infradead.org>
Cc: T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060417162345.GA9609@infradead.org>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
	 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 17 Apr 2006 13:03:24 -0400
Message-Id: <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 17:23 +0100, Christoph Hellwig wrote:
> On Mon, Apr 17, 2006 at 12:06:53PM -0400, Stephen Smalley wrote:
> > > I thought of this, see label_all_processes. Unfortunately I found no way of 
> > > actually doing this. I would need to iterate through the tasklist structure, 
> > > but the task_lock export is going to be removed from the kernel.
> > 
> > So, if built-in isn't an option, propose an interface to the core
> > security framework to allow security modules to perform such
> > initialization without needing to directly touch the lock themselves
> 
> NACK.  The whole idea of loading security modules after bootup is flawed.
> Any scheme that tries to enumerate process and other entinity after the
> fact for access control purposes is fundamentally flawed.  We're not going
> to add helpers or exports for it, I'd rather remove the ability to build
> lsm hook clients modular completely.

Or, better, remove LSM itself ;)

-- 
Stephen Smalley
National Security Agency

