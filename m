Return-Path: <linux-kernel-owner+w=401wt.eu-S1422771AbWLUHGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWLUHGD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWLUHGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:06:03 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:21030 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422771AbWLUHGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:06:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ZSt/m/P+v1+a7rEfcrn8Kpraqyo5fnS1+FHxM4rkisAb4PF5wp7Z+tDoGzLe/MhU/L4hxAC1DmDGt2qrKELRpHI5N7tEe+WBey02qIEuVq/ftW0j3GOopkPKZSguKbo4n4B6Y/3GPOHmmYCpBDfHENUc5HMZoUnIpulV0fEjyfQ=  ;
X-YMail-OSG: _ECHhegVM1kGZxRJn9HCRDuZ3CNz5liOotpfnEkx5xGdbd15G9qmSkHKgFJaLPgDli.ROcogEGh5ptEOC4ZHMiPP34IsGjJCi2Uq9guh3JVIe7kTy8GJ4lQ0FQTtPkPdoo2xrd5BQLHGJxRstufu59lo3oAPjXxdyhZj_ZO_mYHXVZfnhlrZLmG7pZ72
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Changes to sysfs PM layer break userspace
Date: Wed, 20 Dec 2006 23:05:57 -0800
User-Agent: KMail/1.7.1
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612202056.28177.david-b@pacbell.net> <20061220210214.f9b94889.akpm@osdl.org>
In-Reply-To: <20061220210214.f9b94889.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202305.57791.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 9:02 pm, Andrew Morton wrote:

> > ... see my original reply in this thread.  If "the answer" is
> > to involve making PCI devices work again, better solutions include reverting
> > the patch I mentioned (adding the suspend_late/resume_early support to PCI)
> > or a version of what Matthew has produced (poking through bus layers so
> > that test can be made to fail when the bus supports those methods but the
> > specific device's driver doesn't use them).
> > 
> 
> We appear to have a choice of three options.  But I see no fix in Greg's
> tree.  Please let's not just accidentally forget to do this.

Plus the fourth "leave it be" option, which I guess you're voting against.
Of those options, I'd go for something like Matthew's patch to add a new
layer-punching hook.  (I'll look at his latest tomorrow, and do something
appropriate with it.)

It's interesting that there was no evident motion on these network PM
issues after the OLS (and then netdev) discussion last summer ... but
there is now much more active discussion.  Evidently PM issues are still
ignored until a fire gets set.

- Dave

