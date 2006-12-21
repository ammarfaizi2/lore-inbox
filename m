Return-Path: <linux-kernel-owner+w=401wt.eu-S1161147AbWLUCSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWLUCSq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWLUCSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:18:46 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:46299 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161143AbWLUCSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:18:45 -0500
Date: Thu, 21 Dec 2006 02:18:32 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Michael Wu <flamingice@sourmilk.net>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-ID: <20061221021832.GA723@srcf.ucam.org>
References: <20061220042648.GA19814@srcf.ucam.org> <20061220144906.7863bcd3@dxpl.pdx.osdl.net> <20061221011209.GA32625@srcf.ucam.org> <200612202105.31093.flamingice@sourmilk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612202105.31093.flamingice@sourmilk.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Network drivers that don't suspend on interface down
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 09:05:27PM -0500, Michael Wu wrote:

> Softmac isn't the only wireless code that likes to be configured after going 
> up first. Configuring after the card goes up has generally been more 
> reliable, though that should not be necessary and is a bug IMHO. 

Ok, that's nice to know. 

> In order to scan, we need to have the radio on and we need to be able to send 
> and receive. What are you gonna turn off?

The obvious route would be to power the card down, but come back up 
every two minutes to perform a scan, or if userspace explicitly requests 
one. Would this cause problems in some cases?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
