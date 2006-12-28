Return-Path: <linux-kernel-owner+w=401wt.eu-S1753060AbWL1QFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbWL1QFA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874AbWL1QFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:05:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34406 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbWL1QE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:04:59 -0500
Subject: Re: Changes to PM layer break userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <20061228133137.409b85d2@localhost.localdomain>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061222210937.GD3960@ucw.cz>
	 <200612232302.06151.david-b@pacbell.net>
	 <20061228133137.409b85d2@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 28 Dec 2006 17:04:48 +0100
Message-Id: <1167321889.3281.4289.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 13:31 +0000, Alan wrote:
> > Seems to me anyone really desperate to put PCI devices into a low
> > power mode, without driver support at the "ifdown" level, would be
> > able just "rmmod driver; setpci".  
> 
> Incorrect for very obvious reasons - there may be two devices driven by
> the same driver one up and one down.

btw this same "incorrect" applies to the sysfs method, that also does a
more or less uncontrolled/uncoordinated power state switch.

All the more reason to have the "normal" device interfaces do the right
thing, so that the kernel has a standing chance to coordinate it
properly.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

