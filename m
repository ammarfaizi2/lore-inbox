Return-Path: <linux-kernel-owner+w=401wt.eu-S932738AbWLTFOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWLTFOx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 00:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWLTFOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 00:14:53 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:45427 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932738AbWLTFOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 00:14:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MTSmWq3eG1qTvQ7SEDRY0aU/rgo5H6/evUb3RkghKoKtswkc4SFRWWVK7TVLUd/IZXipfNPAsz4tEpqByERDdj075Fi+2nz94TJONZ3+vqfafwrQ0M5MSGso/wC/7K7t3VPH5zUIOsmiUnyEvjgIPHF8AYi70XmAEjN+DmaaP70=  ;
X-YMail-OSG: T9IO9tsVM1kB1id3BOdRMLv1bhyICEaTHN950_NaxYIcR5c_VdCMFEAEtwN1UZ.zijKcmcoFxhcC6Xy68akXI5W__Maz66WSmbEj5eRznRSBzeGNm9ORwPfuEJJXf7uE5Lw9rZ9NypG2dKI2DHfA88XQqNdnAs52.C3h63lJLTBPSX2q33C.YRpnTkQd
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Changes to PM layer break userspace
Date: Tue, 19 Dec 2006 21:14:49 -0800
User-Agent: KMail/1.7.1
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org>
In-Reply-To: <20061220042648.GA19814@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612192114.49920.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 8:26 pm, Matthew Garrett wrote:
> On Tue, Dec 19, 2006 at 07:59:42PM -0800, David Brownell wrote:

> The existence of the power/state interface wasn't a bug - it was a 
> deliberate decision to add it. It's the only reason the 
> dpm_runtime_suspend() interface exists. 

All that buggy infrastructure talks together, yes.  Those dpm_*()
calls are in the same "will remove" task item.


> It's perfectly reasonable to  
> refer to it as a flawed interface, or perhaps even a buggy one. But in 
> itself, it's clearly not a bug.

This class of bug is also called a "design bug" or sometimes "mistake".


> > In contrast, the /sys/devices/.../power/state API has never had many
> > users beyond developers trying to test their drivers (without taking
> > the whole system into a low power state, which probably didn't work
> > in any case), and has *always* been problematic.  And the change you
> > object to doesn't "break" anything fundamental, either.  Everything
> > still works.
> 
> It's used on every Ubuntu and Suse system,

Odd how the relevant Suse developers didn't mention any issues with
those files going away, any of the times problems with them were
discussed on the PM list.  Also, I have a Suse system that doesn't
use those files for anything ... maybe only newer release use it.

I've got some Ubuntu going too, which hasn't (visibly) suffered from
any of these changes.

- dave
