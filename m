Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTFIXC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTFIXC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:02:57 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:46986 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262269AbTFIXCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:02:52 -0400
Date: Tue, 10 Jun 2003 01:16:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New system device API
Message-ID: <20030609231601.GE508@elf.ucw.cz>
References: <20030609212348.GB508@elf.ucw.cz> <Pine.LNX.4.44.0306091428470.11379-100000@cherise> <20030609220442.GD508@elf.ucw.cz> <1055200110.2119.9.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055200110.2119.9.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Can I bring up an issue a little off topic? Is it currently possible for
> us to say 'I want to suspend X but not Y?', and if so how is it done? I
> ask because someone recently mentioned the spinning up and down of IDE
> during swsusp. That occurs because we can (AFAIK) only say suspend
> everything at the moment. It would be good if we could put to sleep
> everything except your system devices and the devices used to write
> the

Well, you need to suspend devices used to write the image, too, so you
have state to return to after resume. You only do not want disks to
spin down. Perhaps disk can just special-case it ("If I am going to
swsusp, I need to save state, but do not really need to spin down").

> image while preparing the image, and only suspend the remaining devices
> once the image has been written. Is such a thing already implemented?
> 
> As an aside, I've gone to a 1.0 pre series for 2.4 swsusp, so it
> shouldn't be long before I'm working on 2.5. I've already created
> swsusp25.bkbits.net, but nothing is in it at the moment. My intention is
> that as I prepare the patches and Pavel says 'That looks ok', I'll add
> them to the tree and we can ask Linus to pull from there.

Well, I'm not allowed to use bitkeeper, so bk tree is not too exciting
for me. But I can bless patches all right ;-).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
