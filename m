Return-Path: <linux-kernel-owner+w=401wt.eu-S1161098AbWLUNOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWLUNOe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWLUNOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:14:34 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:37806 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161100AbWLUNOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:14:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=EhDm4jG++ITUDRPcFjt6sE2XXaIOgqIftnmKCfRTLKPE+MRvRsQWq76PtjQ6LK5RPPfMTrr0LiLla1ehD+5m2Z6rox0cypJ4hJC1YRPTkoQbnwScgxQadAmjPdIOwY5yWYBaGCfnipdNvMWCKNEm+MXYowbjjAFUYs4SXd0wRnU=
Subject: Re: Network drivers that don't suspend on interface down
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Dan Williams <dcbw@redhat.com>
Cc: stefan@loplof.de, Matthew Garrett <mjg59@srcf.ucam.org>,
       Michael Wu <flamingice@sourmilk.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <1166670848.23168.21.camel@localhost.localdomain>
References: <20061220042648.GA19814@srcf.ucam.org>
	 <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
	 <20061221011209.GA32625@srcf.ucam.org>
	 <200612202105.31093.flamingice@sourmilk.net>
	 <20061221021832.GA723@srcf.ucam.org>
	 <1166670848.23168.21.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 08:14:29 -0500
Message-Id: <1166706869.3749.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-20-12 at 22:14 -0500, Dan Williams wrote:
...
....
> Simple == good.  Down == down.  Lets just agree on that and save
> ourselves a lot of pain.

netdevices have well defined operational and administrative state
machines. And very well defined relationship between operational and
administrative status. IOW, care should be invoked not to reinvent.

Power management to me seems like an operational state.
A link could only transition to operational or down depending on 
whether it is "powered" up or down.

To be complete, since a netdevice is a generic construct, nota bene:
- a link could be a wireless association or ethernet cable or a PPP
session or a ATM PVC, or an infrared channel etc. 
- events that result in operational link transitions could be anything
from powering up an ethernet phy with an active cable plugged to an
802.1x auth on a wireless association to a on-demand ppp link seeing an
outgoing packet.

IMO, for this discussion to be meaningful, it would be useful to read
Documentation/networking/operstates.txt
And if you are keen you can then read RFC 2863...

cheers,
jamal

