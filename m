Return-Path: <linux-kernel-owner+w=401wt.eu-S964872AbWLTEPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWLTEPT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 23:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWLTEPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 23:15:19 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:40296 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964872AbWLTEPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 23:15:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MLYqwAvKEjcrpKgn7js9mRbdZ4tj1j2CJamJBYs0YDa88NetX77+PdJ8o5c79oewmmUbLi744oC1fULQOqEu9lQTGIB3lNM8FA53D1ZN9Me/2xfr0OEpodyxwOTtbnDPKcLS8bw0/zqGzsbG68bftJ2/d03y6vTaXQq7mUQAsv0=  ;
X-YMail-OSG: kiley9oVM1lAfSJVb0MQ77ZKlcUzy8Xapqz8oDMuSftRa4u_7b5nrPrw.vGhh0_gQMp8xg.piOe8ZQclgge5gY8nHDer1sMkC.z6UrFMN1fbYSbkhNlox7ABKn.fNUJ697WxIyR0qqr1B6znaEVbCfs0EkqbYwCl4iizfsPckjli_QV9zNeqiKcFW0KD
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Changes to PM layer break userspace
Date: Tue, 19 Dec 2006 20:15:14 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612191919.36813.david-b@pacbell.net> <20061220034315.GA19440@srcf.ucam.org>
In-Reply-To: <20061220034315.GA19440@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612192015.14587.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 7:43 pm, Matthew Garrett wrote:

> > Do you have an alternate solution?
> 
> How about something like this? Entirely untested, but I think it shows 
> the basic idea.

Other than indentation/whitespace bugs, it seems to encapsulate the
layering violation needed to get those deprecated files working again
for PCI (and platform_bus).   I'd rename the new bus method though;
maybe "pm_has_noirq_stage()" or somesuch.  Your name is so generic that
it'd be a surprise if the answer were ever "no"!

You should also list this new call in the feature-removal.txt entry for
stuff that gets removed with /sys/devices/.../power/state files, since
it's another mechanism that only exists to prop up that broken API,
and should vanish at the same time that API does.

- Dave

