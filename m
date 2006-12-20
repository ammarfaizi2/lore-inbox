Return-Path: <linux-kernel-owner+w=401wt.eu-S964899AbWLTFwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWLTFwZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 00:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWLTFwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 00:52:25 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:34253 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbWLTFwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 00:52:24 -0500
Date: Wed, 20 Dec 2006 05:52:09 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Greg KH <gregkh@suse.de>
Cc: David Brownell <david-b@pacbell.net>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Message-ID: <20061220055209.GA20483@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220053417.GA29877@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:34:17PM -0800, Greg KH wrote:

> I would be very interested to see any newer SuSE programs using that
> interface.  Just point them out to me and I'll quickly fix them.

As far as I can tell, powersaved still uses these.. I'm not quite sure 
how you can fix it without just removing the functionality from it...

> And yes, as a SuSE developer (and one of the people in charge of the
> SuSE kernels), I have no problem with these files just going away.
> Because, as David keeps repeating, they are broken and wrong.

In the common case, it works perfectly well for the management of 
individual PCI devices. Yes it's "wrong", in much the same way as (say) 
the IDE bus registration/unregistration code. But we keep that around 
because despite it being even more broken than devices/.../power/state, 
people are still actually using it and we haven't provided any sort of 
alternative.

Seriously. How many pieces of userspace-visible functionality have 
recently been removed without there being any sort of alternative?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
