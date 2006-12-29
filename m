Return-Path: <linux-kernel-owner+w=401wt.eu-S1754409AbWL2FaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbWL2FaS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbWL2FaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:30:18 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:41432 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753990AbWL2FaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:30:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=zKfcTGZ9g9ONbvdDKvngsGaijIdioAlhDj2HkdTz2nUFRk4wARsCR0Q4/q+5Ja7CeppitftLdYbKVZMFBgSlMLEfhQNIKkcGjWVikADgyTjow/gK/O/stGT3GvtG/JIb6hUpoOlUkUbGSlD2lj+gDpBmdj/0zbMDFCWGBKSeh9w=  ;
X-YMail-OSG: H9Ap4eYVM1lyLS9CHOXgEEn94BOEz.0IOh0NKFQZ.9sO1i7iK8Xlz0Iqt2A8Hv73zGnWMsUt6dq.2VF1ZBTpZt31iBw8XshbKgNujx7zlxGG_hUqmj0d6K_GofNUQZOdw2ql9.SQ7D5A91G5Lrzuj4mlZ7jNsd14F065zk8CeU_lEwzhBZID0VU6bfVv
From: David Brownell <david-b@pacbell.net>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Changes to PM layer break userspace
Date: Thu, 28 Dec 2006 21:27:45 -0800
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612232302.06151.david-b@pacbell.net> <20061228133137.409b85d2@localhost.localdomain>
In-Reply-To: <20061228133137.409b85d2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612282127.46504.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 5:31 am, Alan wrote:
> > Seems to me anyone really desperate to put PCI devices into a low
> > power mode, without driver support at the "ifdown" level, would be
> > able just "rmmod driver; setpci".  
> 
> Incorrect for very obvious reasons - there may be two devices driven by
> the same driver one up and one down.

Let me emphasize "desperate".  ;)

The examples given were all cases where that didn't seem to be an issue.

But agreed, the best approach is really to make devices not in active
use (i.e. before "ifup", after "ifdown" ... maybe even whenever no
driver is bound to the device) stay in low power states.

- Dave
