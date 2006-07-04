Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWGGNkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWGGNkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWGGNka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:40:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40205 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750843AbWGGNka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:40:30 -0400
Date: Tue, 4 Jul 2006 18:37:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Problems porting asus_acpi to LED subsystem
Message-ID: <20060704183750.GD4420@ucw.cz>
References: <20060703203958.GA8093@phoenix> <20060704085022.GB1755@elf.ucw.cz> <20060704145040.GA3611@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704145040.GA3611@phoenix>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-07-06 10:50:40, Thomas Tuttle wrote:
> On July 04 at 04:50 EDT, Pavel Machek hastily scribbled:
> > I _guess_ the LED subsystem can be called from interrupt, and ACPI
> > does not like that. So you probably need to use workqueue to defer
> > setting a bit.
> 
> Ew, I would personally think that the LED subsystem should do this
> itself...

That would make LEDs factor 10000 or so slower on reasonable
platforms, sorry. But having flag 'this led needs process context'
might be god thing. Patch welcome.

> Anyway, can you give me a pointer on how to do this?  I've never used
> workqueues before.  (I've coded a grand total of about 40 lines of
> kernel code, and only about 20 work.)

grep is your friend, or some kernel programming intro.I do not have
any example near. Or maybe kernelnewbies.org.

-- 
Thanks for all the (sleeping) penguins.
