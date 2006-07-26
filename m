Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWGZOKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWGZOKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWGZOKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:10:04 -0400
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:31183 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1751629AbWGZOKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:10:02 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Date: Wed, 26 Jul 2006 15:10:02 +0100
User-Agent: KMail/1.9.3
Cc: David Lang <dlang@digitalinsight.com>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
References: <20060725034247.GA5837@kroah.com> <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz> <20060726130207.GC23701@stusta.de>
In-Reply-To: <20060726130207.GC23701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261510.03098.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 14:02, Adrian Bunk wrote:
> On Tue, Jul 25, 2006 at 09:47:43AM -0700, David Lang wrote:
> > On Tue, 25 Jul 2006, Andrew de Quincey wrote:
> > >On Tuesday 25 July 2006 10:55, Arnaud Patard wrote:
> > >>Greg KH <gregkh@suse.de> writes:
> > >>
> > >>Hi,
> > >>
> > >>>We (the -stable team) are announcing the release of the 2.6.17.7
> > >>> kernel.
> > >>
> > >>Sorry, but doesn't compile if DVB_BUDGET_AV is set :(
> > >>
> > >>>Andrew de Quincey:
> > >>>      v4l/dvb: Fix budget-av frontend detection
> > >
> > >In fact it is just this patch causing the problem:
> >
> > <SNIP>
> >
> > >Sorry, I had so much work going on in that area I must have diffed the
> > >wrong
> > >kernel when I created this patch. :(
> >
> > is it reasonable to have an aotomated test figure out what config options
> > are relavent to a patch (or patchset) and test compile all the
> > combinations to catch this sort of mistake?
>
> If you think about it, you'll notice it's definitely not reasonable:
>
> #include <linux/module.h> brings you a dependency on 5 config options.
> #include <linux/pci.h> brings you a dependency on 6 config options.
>
> By only including these two headers you are at 2048 combinations.
> The number of valid configurations will be lower, but 500 test compiles
> sound realistically.
>
> With have a dozen #include's you might need more than a million test
> compiles.
>
> With a dozen #include's, you might need a trilion [1] test compiles.
>
>
> Compile errors are quickly catched and don't cause any serious problem.
>
> What bothers me more is that noone tested this patch against the kernel
> it was applied against.
>
> The submitter didn't test it works (he didn't even test the compilation).

Yes I did - I didn't test the final generated patch unfortunately since I 
assumed it worked. The kernel I _meant_ to diff against worked perfectly :(
