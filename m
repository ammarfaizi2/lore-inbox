Return-Path: <linux-kernel-owner+w=401wt.eu-S932928AbWLSUIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbWLSUIQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932932AbWLSUIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:08:16 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:39742 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932928AbWLSUIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:08:14 -0500
Date: Tue, 19 Dec 2006 20:08:03 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, gregkh@suse.de
Message-ID: <20061219200803.GA14332@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <1166556889.3365.1269.camel@laptopd505.fenrus.org> <20061219194410.GA14121@srcf.ucam.org> <1166558602.3365.1271.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166558602.3365.1271.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to sysfs PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:03:21PM +0100, Arjan van de Ven wrote:

> humm shouldn't the driver do this when the interface is brought down?
> sounds like you're playing with fire to do this behind the drivers'
> back....

I'm not sure. Suspending the chip means you lose things like link beat 
detection, so it's not something you necessarily want to automatically 
tie to something like interface status. Some chips support more 
fine-grained power management, so we could do something more sensible in 
that case - but right now, there doesn't seem to be a lot of driver 
support for it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
