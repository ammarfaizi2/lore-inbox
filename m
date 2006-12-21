Return-Path: <linux-kernel-owner+w=401wt.eu-S1161072AbWLUAOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWLUAOb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWLUAOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:14:31 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39088 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161076AbWLUAO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:14:29 -0500
Date: Thu, 21 Dec 2006 01:11:12 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
Message-ID: <20061221001111.GA4016@electric-eye.fr.zoreil.com>
References: <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <1166621931.3365.1384.camel@laptopd505.fenrus.org> <20061220143134.GA25462@srcf.ucam.org> <1166629900.3365.1428.camel@laptopd505.fenrus.org> <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> :
[...]
>    IMHO:
> 	When device is down, it should:
> 	 a) use as few resources as possible:
> 	       - not grab memory for buffers
> 	       - not assign IRQ unless it could get one
> 	       - turn off all power consumption possible
> 	 b) allow setting parameters like speed/duplex/autonegotiation,
>             ring buffers, ... with ethtool, and remember the state
> 	 c) not accept data coming in, and drop packets queued

<nit>
Imho speed/duplex/autoneg is not the business of the device: they belong
to the phy and it's up to it to decide if its state allows to set the
requested parameters or not.
</nit>

-- 
Ueimor
