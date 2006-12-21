Return-Path: <linux-kernel-owner+w=401wt.eu-S1161113AbWLUBPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWLUBPm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWLUBPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:15:41 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:40984 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161113AbWLUBPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:15:40 -0500
Date: Thu, 21 Dec 2006 01:15:26 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dan Williams <dcbw@redhat.com>
Cc: Jiri Benc <jbenc@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20061221011526.GB32625@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <20061220150009.1d697f15@griffin.suse.cz> <1166638371.2798.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166638371.2798.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Network drivers that don't suspend on interface down
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 01:12:51PM -0500, Dan Williams wrote:

> Entirely correct.  If the card is DOWN, the radio should be off (both TX
> & RX) and it should be in max power save mode.  If userspace expects to
> be able to get the card to do _anything_ when it's down, that's just
> 110% wrong.  You can't get link events for many wired cards when they
> are down, so I fail to see where userspace could expect to do anything
> with a wireless card when it's down too.

Because it works on the common hardware? If there's documentation about 
what userspace can legitimately expect, then I'm happy to defer to that. 
But in the absence of any indication as to what functionality users can 
depend on, deciding that existing functionality is a bug is, well, 
impolite.

> Also, how does rfkill fit into this?  rfkill implies killing TX, but do
> we have the granularity to still receive while the transmit paths are
> powered down?

Is rfkill not just primarily an interface for us getting events when the 
radio changes state? Every time I read up on it I get a little more 
confused - some time I really need to make sense of it...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
