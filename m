Return-Path: <linux-kernel-owner+w=401wt.eu-S932944AbWLSUzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944AbWLSUzr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932942AbWLSUzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:55:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37676 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944AbWLSUzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:55:46 -0500
Subject: Re: Changes to sysfs PM layer break userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, gregkh@suse.de
In-Reply-To: <20061219203251.GA14648@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <1166556889.3365.1269.camel@laptopd505.fenrus.org>
	 <20061219194410.GA14121@srcf.ucam.org>
	 <1166558602.3365.1271.camel@laptopd505.fenrus.org>
	 <20061219200803.GA14332@srcf.ucam.org>
	 <1166559785.3365.1276.camel@laptopd505.fenrus.org>
	 <20061219203251.GA14648@srcf.ucam.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 19 Dec 2006 21:55:43 +0100
Message-Id: <1166561743.3365.1282.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 20:32 +0000, Matthew Garrett wrote:
> On Tue, Dec 19, 2006 at 09:23:05PM +0100, Arjan van de Ven wrote:
> > On Tue, 2006-12-19 at 20:08 +0000, Matthew Garrett wrote:
> > > I'm not sure. Suspending the chip means you lose things like link beat 
> > > detection, so it's not something you necessarily want to automatically 
> > > tie to something like interface status. 
> > 
> > right now the "spec" for Linux network drivers assumes that you put the
> > NIC into D3 on down, except for cases where Wake-on-Lan is enabled etc.
> 
> Really? I can't find any drivers that seem to do this. The only calls to 
> pci_set_power_state seem to be in the suspend, resume, init and exit 
> routines.

your grep missed tg3.c for example, which has a wrapper around the power
state code and goes to D3hot on downing of the interface. (just the
first one I looked at as a "reference driver", others probably do the
same thing)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

