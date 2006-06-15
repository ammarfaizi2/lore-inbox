Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWFOGkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWFOGkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWFOGkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:40:45 -0400
Received: from mail.gmx.de ([213.165.64.21]:30337 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932446AbWFOGkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:40:45 -0400
X-Authenticated: #14349625
Subject: Re: bad command responsiveness Proliant DL 585
From: Mike Galbraith <efault@gmx.de>
To: david@dworf.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <449060EE.60608@dworf.com>
References: <448FC1CE.9090108@dworf.com>
	 <1150278161.7994.13.camel@Homer.TheSimpsons.net> <449060EE.60608@dworf.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 08:44:22 +0200
Message-Id: <1150353862.8097.61.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 21:18 +0200, David Osojnik wrote:
> here is the output of SysRq-T and SysRq-M:
> 
> http://www.dworf.com/sysrq.txt
> 
> any ideas?

Not really.

I see I/O jammed up on reiserfs:.text.lock.journal, but you said
reiserfs and ext3 both stall the same way.  If the journal is in the
raid, I'd try moving it, but I can't really imagine seek troubles
leading to 15 minutes of grinding.  I noticed that those last two
instances of bash got nailed because of atime.  Do things get any better
if mounted noatime, nodiratime?

	-Mike

