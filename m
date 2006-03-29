Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWC2Emg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWC2Emg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWC2Emf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:42:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750822AbWC2Eme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:42:34 -0500
Subject: Re: BUG in Linux 2.6.16/2.6.16.1 (compilation failure of third
	party software)
From: Arjan van de Ven <arjan@infradead.org>
To: Thierry Godefroy <thgodef@nerim.net>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060329012122.0c533fc6.thgodef@nerim.net>
References: <20060328202905.18cb2cb0.thgodef@nerim.net>
	 <1143586271.11792.118.camel@mindpipe>
	 <20060329012122.0c533fc6.thgodef@nerim.net>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 06:42:31 +0200
Message-Id: <1143607351.3049.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 01:21 +0200, Thierry Godefroy wrote:
> On Tue, 28 Mar 2006 17:51:11 -0500, Lee Revell wrote:
> 
> > On Tue, 2006-03-28 at 20:29 +0200, Thierry Godefroy wrote:
> > > Paragon_NTFS_3.x.v5.1 fails to compile (with gcc v3.4.3) with the following
> > > errors:
> > 
> > It's not a bug when an upgrade causes third party kernel modules not to
> > compile - your code needs to be updated to work with 2.6.16.
> 
> Oh, yeah ?... Really ?... Please, read the errors before drawing hasted conclusions...
> The errors occur after the mere #inclusion of Linux headers. Here is a simple "code"
> which will trigger the error:
> 
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
> 
> #include <linux/module.h>
> 
> int main() {
> 	return 0;
> }
> 
> And I don't see anything wrong in that code...


then look again. Userspace that defines __KERNEL__ .... man that isn't
going ot work. __KERNEL__ is the ONLY safeguard we have to protect
userspace from miscompiling, and we highly assume userspace doesn't set
it. If this program does that then it really deserves all it gets.


