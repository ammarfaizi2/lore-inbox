Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbTFRQ6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265386AbTFRQ6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:58:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:33665 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265383AbTFRQ6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:58:41 -0400
Message-Id: <5.2.0.9.2.20030618190128.02763980@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 18 Jun 2003 19:17:00 +0200
To: William Lee Irwin III <wli@holomorphy.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler starvation
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>, davidm@hpl.hp.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030618165227.GK26348@holomorphy.com>
References: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
 <1055922807.585.5.camel@teapot.felipe-alfaro.com>
 <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:52 AM 6/18/2003 -0700, William Lee Irwin III wrote:
>On Wed, Jun 18, 2003 at 02:04:45PM +0200, Mike Galbraith wrote:
> > I've got thud licked (without the restricting sleep to time_slice),
> > test-starve works right as well, and interactivity is up.  Tasks waking
> > each other in a loop is a bitch and a half though, and need to be beaten
> > about the head and shoulders.  Going to a synchronous wakeup for pipes
> > (talking stock kernel now) cures irman process_load's ability to starve...
> > IFF you're running it from a vt.  If you're in an xterm, it'll still climb
> > up from the bottom (only place where it can't starve anybody) and starve
> > via pass-the-baton wakeup DoS.  That will/does take the joy out of using
> > xmms.  If xmms didn't use multiple threads, it'd be much worse... right
> > now, you'll lose eye-candy [cpu hungry visualization stuff] before you 
> lose
> > sound [at next song].
>
>That's great. I'd love to see the patch.

If I can get the kinks worked out and still have something left.  I'm 
gaining on the darn thing, but only a net millimeter at a time... with much 
cha-cha-cha action in between ;-)

         -Mike 

