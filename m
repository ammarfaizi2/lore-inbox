Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269194AbUIHXJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269194AbUIHXJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUIHXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:09:12 -0400
Received: from netblock-66-159-231-38.dslextreme.com ([66.159.231.38]:16048
	"EHLO mail.cavein.org") by vger.kernel.org with ESMTP
	id S269194AbUIHXJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:09:08 -0400
Date: Wed, 8 Sep 2004 16:07:21 -0700 (PDT)
From: Richard A Nelson <cowboy@debian.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
In-Reply-To: <Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet>
Message-ID: <Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
  <20040908020402.3823a658.akpm@osdl.org> <1094635403.1985.12.camel@sisko.scot.redhat.com>
 <Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Richard A Nelson wrote:

> On Wed, 8 Sep 2004, Stephen C. Tweedie wrote:
>
> > On Wed, 2004-09-08 at 10:04, Andrew Morton wrote:
> >
> > > >   Unable to handle kernel paging request at virtual address 6b6b6b93
> > > > ...
> > > >   EIP: 0060:[__journal_clean_checkpoint_list+199/240]    Not tainted VLI
> > >
> > > This might have been caused by a fishy latency-reduction patch.  I today
> > > dropped that patch so could you please test next -mm and let me know?
> >
> > That, or preempt.  If the next -mm still breaks, time to hunt for the
> > preempt problem, I guess.
>
> Ok, if it still fails (I'll have to wait until this afternoon for the
> true test - dpkg breaks it everytime), I'll check out preempt.

Well, it looks like backing out the patch was sufficient, I've made it
through the torture that is a dpkg install (70+meg).

So we needn't (at this time) look to preempt.

-- 
Rick Nelson
<LackOfKan> What are 'bots'?
<``Erik> rsg is a bot, not a human, not a human usable client, just a bot.
<``Erik> about the same as a quake bot, except irc bots are (usually)
         built to help, not shoot your ass full of holes
