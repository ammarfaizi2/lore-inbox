Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbTAFTG4>; Mon, 6 Jan 2003 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbTAFTG4>; Mon, 6 Jan 2003 14:06:56 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:53639 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S265190AbTAFTGz>; Mon, 6 Jan 2003 14:06:55 -0500
Date: Mon, 6 Jan 2003 12:15:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
Message-ID: <20030106191531.GE796@opus.bloom.county>
References: <20030106190648.GD796@opus.bloom.county> <Pine.LNX.4.33L2.0301061104410.15416-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301061104410.15416-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 11:05:49AM -0800, Randy.Dunlap wrote:
> On Mon, 6 Jan 2003, Tom Rini wrote:
> 
> | On Mon, Jan 06, 2003 at 10:57:01AM -0800, Randy.Dunlap wrote:
> | > On Mon, 6 Jan 2003, Tom Rini wrote:
> | >
> | > | On Thu, Jan 02, 2003 at 03:09:17PM -0800, Randy.Dunlap wrote:
> | > |
> | > | > This patch to 2.5.54 make LOG_BUF_LEN a configurable option.
> | > | > Actually its shift value is configurable, and that keeps it
> | > | > a power of 2.
> | > |
> | > | Erm, why not just prompt for an int, slightly change the help wording,
> | > | and then just give a default int value directly.
> | > |
> | > | Flexibility is good for everyone.
> | >
> | > Sure, I like that, but LOG_BUF_LEN must be a power of 2 (currently)
> | > and I was trying not to rewrite that circular buffer code, that's all.
> | > However, I will if that's desirable.
> |
> | I actually meant prompting for the shift value itself.
> 
> I did think of that, but it's too user-unfriendly IMO.
> Heck, it's even developer-unfriendly IMO.

I don't see how it's any worse than giving them a choice of 3-4 preset
values.  Especially with the current defaults being given as the
if-in-doubt option :)

This is would also be a good reason to have a CONFIG_ADVANCED_OPTIONS
globally, ala what's in arch/ppc/Kconfig now.  If selected, you can pick
some 'user-unfriendly' options, and otherwise a default is picked for
you.

This is also a good argument for the TWEAKS stuff I talked about a while
ago, but haven't found the time yet to finish the dependancy stuff (it
works ala CONFIG stuff now, _except_ for a new TWEAK key).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
