Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTFRQis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTFRQis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:38:48 -0400
Received: from holomorphy.com ([66.224.33.161]:21929 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265227AbTFRQio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:38:44 -0400
Date: Wed, 18 Jun 2003 09:52:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>, davidm@hpl.hp.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler starvation
Message-ID: <20030618165227.GK26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mike Galbraith <efault@gmx.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
References: <1055922807.585.5.camel@teapot.felipe-alfaro.com> <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 02:04:45PM +0200, Mike Galbraith wrote:
> I've got thud licked (without the restricting sleep to time_slice), 
> test-starve works right as well, and interactivity is up.  Tasks waking 
> each other in a loop is a bitch and a half though, and need to be beaten 
> about the head and shoulders.  Going to a synchronous wakeup for pipes 
> (talking stock kernel now) cures irman process_load's ability to starve... 
> IFF you're running it from a vt.  If you're in an xterm, it'll still climb 
> up from the bottom (only place where it can't starve anybody) and starve 
> via pass-the-baton wakeup DoS.  That will/does take the joy out of using 
> xmms.  If xmms didn't use multiple threads, it'd be much worse... right 
> now, you'll lose eye-candy [cpu hungry visualization stuff] before you lose 
> sound [at next song].

That's great. I'd love to see the patch.


-- wli
