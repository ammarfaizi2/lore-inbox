Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUCDKCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 05:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUCDKCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 05:02:51 -0500
Received: from dinsnail.net ([217.160.166.159]:8096 "EHLO heinz.dinsnail.net")
	by vger.kernel.org with ESMTP id S261775AbUCDKCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 05:02:49 -0500
Date: Thu, 4 Mar 2004 10:27:59 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
To: Greg KH <greg@kroah.com>
Cc: Ed Tomlinson <edt@aei.ca>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304092759.GA95456@weiser.dinsnail.net>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca> <20040303151433.GC25687@kroah.com> <20040304012233.GB22511@wonderland.linux.it> <20040304012813.GD2207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304012813.GD2207@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 05:28:13PM -0800, Greg KH wrote:
> > This does not solve the problem of drivers which do not have matching
> > hardware, like PPP and loop device. I do not mind unconditionally loading
> > these modules at boot, but there has to be a way to recognize them: I do
> > not think it is acceptable to load *all* modules available on the system
> > (what is the point of having a modular kernel then?).
> Then have your "use the loop device" or "use the ppp device" load the
> module before it is used.  Or manually create the dev node and hope that
> kmod and its aliases work...
AFAICS both require root privileges and the latter will break with
dynamic device numbers issued by the kernel. The previous model enabled
normal users to have the kernel adjust to their current requirements
dynamically without the need of being root.
-- 
bye, Micha
