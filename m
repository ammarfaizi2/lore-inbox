Return-Path: <linux-kernel-owner+w=401wt.eu-S932938AbWLNVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbWLNVsv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932955AbWLNVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:48:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:57803 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932954AbWLNVsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:48:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fr6Uq1gaNT0iOHt0wuf6JqsbdMZBX3NrUulFZNokhnpHdh7BqMuXAbIR8tY0IAOkIV55KOdIHNsnXaLta2FAEzBVG02iHCMGvrcSHwI3KJQpNVf0xZ2ikXS5A47DaP3gl4ic5YTMzD1e/RQi9wywVl19o2iKpXFEqnhPrv9XzFM=
Message-ID: <5b8e20700612141348l66af58b6lb6899b710d1d9c14@mail.gmail.com>
Date: Thu, 14 Dec 2006 16:48:48 -0500
From: "Michael Bommarito" <michael.bommarito@gmail.com>
To: "Uli Kunitz" <kune@deine-taler.de>
Subject: Re: [PATCH 2.6.19-git19] BUG due to bad argument to ieee80211softmac_assoc_work
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <341A1CE8-DF10-4CD5-B675-89449256EAB5@deine-taler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5b8e20700612131017n1cd8aff3qbe41351435427e25@mail.gmail.com>
	 <341A1CE8-DF10-4CD5-B675-89449256EAB5@deine-taler.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uli,
  Yes, apologies, I had been waiting for an abandoned bugzilla entry
to get attention, and when I realized it was assigned to a dead-end, I
had simply posted the patch without checking for prior messages.
  I was further confused by the fact that it hadn't made its way into
any of the 19-gitX sets (and for that matter, the window for
2.6.20-rc1 has come and gone and this still remains unfixed), despite
how clear the error was and how trivial the fix seems.

-Mike

On 12/14/06, Uli Kunitz <kune@deine-taler.de> wrote:
> Michael,
>
> I sent a patch to this list on Sunday, that patched the problem. It
> seems to be migrated into the wireless-2.6 git tree.
>
> Regards,
>
> Uli
> Am 13.12.2006 um 19:17 schrieb Michael Bommarito:
>
> > This didn't get much attention on bugzilla and I figured it was
> > important enough to forward along to the whole list since it's been
> > lingering around in ieee80211-softmac since 19-git5 at least.
> > http://bugzilla.kernel.org/show_bug.cgi?id=7657
> >
> > Somebody was passing the whole mac device structure to
> > ieee80211softmac_assoc_work instead of just the assocation work, which
> > lead to much death and locking.
> >
> > Attached is a patch that fixes this (the actual change is two lines
> > but context provided in patch for review).  The dmesg containing call
> > trace is attached to the bugzilla entry above.
> >
> > -Mike
> > -
> > To unsubscribe from this list: send the line "unsubscribe netdev" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Uli Kunitz
>
>
>
>
