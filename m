Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWCCEc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWCCEc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWCCEc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:32:59 -0500
Received: from smtpout.mac.com ([17.250.248.47]:55238 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750790AbWCCEc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:32:58 -0500
Date: Thu, 2 Mar 2006 23:32:49 -0500
From: Kyle Moffett <mrmacman_g4@mac.com>
To: "James C. Georgas" <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] make UNIX a bool
Message-Id: <20060302233249.2aa918f4.mrmacman_g4@mac.com>
In-Reply-To: <1141359278.3582.22.camel@Rainsong.home>
References: <1141358816.3582.18.camel@Rainsong.home>
	<1141359278.3582.22.camel@Rainsong.home>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Mar 2006 23:14:38 -0500 "James C. Georgas" <jgeorgas@rogers.com> wrote: 
> On Thu, 2006-02-03 at 21:32 +0100, Adrian Bunk wrote:
> > We do not have to export symbols we don't want to export to modules but 
> > needed by CONFIG_UNIX.
> 
> Sorry, I must just be dense, or something.
> 
> Is not the only difference between a modular driver and a built in
> driver supposed to be the initialization and cleanup functions?
> 
> I don't see why you would have to expose any additional symbols, over
> and above the existing required symbols, to load your module.

af_unix (IE: CONFIG_UNIX) currently uses the symbol get_max_files.  It 
is the only module that uses that symbol, and that symbol probably should 
not be exported as it's kind of an internal API.  Therefore if we mandate 
that CONFIG_UNIX != m, then that symbol may be properly unexported and 
made private, because nothing modular would use it.  Does that clear 
things up?

P.S.: Please don't remove people from the CC list if you expect them to 
respond to your message (Adrian Bunk readded to CC).

Cheers,
Kyle Moffett
