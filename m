Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317678AbSGOXFx>; Mon, 15 Jul 2002 19:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317687AbSGOXFw>; Mon, 15 Jul 2002 19:05:52 -0400
Received: from mail.zmailer.org ([62.240.94.4]:53649 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317678AbSGOXFw>;
	Mon, 15 Jul 2002 19:05:52 -0400
Date: Tue, 16 Jul 2002 02:08:45 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ketil Froyn <ketil-kernel@froyn.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716020845.Z28720@mea-ext.zmailer.org>
References: <s5g7kjwsn12.fsf@egghead.curl.com> <Pine.LNX.4.44.0207152356430.19217-100000@lexx.infeline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207152356430.19217-100000@lexx.infeline.org>; from ketil-kernel@froyn.net on Mon, Jul 15, 2002 at 11:59:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 11:59:48PM +0200, Ketil Froyn wrote:
> On 15 Jul 2002, Patrick J. LoPresti wrote:
> > Without calling fsync(), you *never* know when the data will hit the
> > disk.
> 
> Doesn't bdflush ensure that data is written to disk within 30 seconds or 
> some tunable number of seconds?

  It TRIES TO, it does not guarantee anything.

  The MTA systems are an example of software suites which have
  transaction requirements.  The goal has been usually stated
  as:  must not fail to deliver.

  Practical implementations without full-blown all encompassing
  transactions will usually mean that the message "will be delivered
  at least once", e.g. double-delivery can happen.

  One view to MTA behaviour is moving the message from one substate
  to another during its processing.

  These days, usually, the transaction database for MTAs is UNIX
  filesystem.   For ZMailer I have considered (although not actually
  done - yet) using SleepyCat DB files for the transaction subsystem.
  There are great challenges in failure compartementalisation, and
  integrity, when using that kind of integrated database mechanisms.
  Getting SEGV is potentially _very_ bad thing!

> Ketil

/Matti Aarnio
