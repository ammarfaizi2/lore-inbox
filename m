Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266639AbUFYUoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUFYUoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUFYUoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:44:25 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:7065 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266639AbUFYUoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:44:02 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Timothy Miller <miller@techsource.com>, Sean Neakums <sneakums@zork.net>
Subject: Re: Collapse ext2 and 3 please
Date: Fri, 25 Jun 2004 22:52:47 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <40DB605D.6000409@comcast.net> <6uoen71pky.fsf@zork.zork.net> <40DC71E8.3020403@techsource.com>
In-Reply-To: <40DC71E8.3020403@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406252252.47266.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 of June 2004 20:41, Timothy Miller wrote:
> Sean Neakums wrote:
> > Timothy Miller <miller@techsource.com> writes:
> >>Sean Neakums wrote:
> >>>I seem to remember somebody, I think maybe Andrew Morton, suggesting
> >>>that a no-journal mode be added to ext3 so that ext2 could be removed.
> >>>I can't find the message in question right now, though.
> >>
> >>As an option, that might be nice, but if everyone were to start using
> >>ext3 even for their non-journalled file systems, the ext2 code would
> >>be subject to code rot.
> >
> > My paraphrase is at fault here.  In the above, "removed" == "removed
> > from the kernel tree".
>
> I understood that.
>
> Let me be more clear.  I agree with other people's comments to the
> effect that ext2 and ext3 have different goals and therefore different
> and potentially incompatible optimizations.  If ext3 had a mode that
> made it equivalent to ext2, which encouraged people to only compile in
> ext3 even for ext2 partitions (to save on kernel memory), then future
> ext2 code bases would get less use and therefore less testing and
> therefore more code rot.
>
> It is reasonable to allow the redundancy between ext2 and ext3 in order
> to allow them to diverge.  This kind of future-proofing mentality
> underlies the reasons why kernel developers don't want to completely
> stablize the module ABI, for example.
>

Let me add my 2c, please.

I think that the most of users will use ext3 or reiserfs anyway, unless they 
actually _prefer_ ext2 for some reasons (let's face it: the most of users 
just follow the distribution defaults and the most of distributors set either 
ext3 or reiserfs as a default).  This, however, confines the use of ext2 to a 
(relatively) small group of users having special needs and means that the 
future ext2 code will get less testing in any case, just like old device 
drivers do (eg. old CD-ROM drivers ;-)).

I'm not for collapsing the ext2 and ext3 code bases, but IMHO your argument 
does not apply.

I think that the good reason for keeping both ext* code bases in the kernel 
tree is that _there_ _are_ _some_ people who will need ext2 for some 
purposes, so why should we pull the carpet from under them?

Yours,
rjw

----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
