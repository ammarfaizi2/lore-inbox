Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTFIXNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTFIXNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:13:07 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:45266 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262285AbTFIXNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:13:05 -0400
Date: Tue, 10 Jun 2003 01:26:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New system device API
Message-ID: <20030609232616.GF508@elf.ucw.cz>
References: <20030609212348.GB508@elf.ucw.cz> <Pine.LNX.4.44.0306091428470.11379-100000@cherise> <20030609220442.GD508@elf.ucw.cz> <1055200110.2119.9.camel@laptop-linux> <20030609231601.GE508@elf.ucw.cz> <1055201047.2119.18.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055201047.2119.18.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Can I bring up an issue a little off topic? Is it currently possible for
> > > us to say 'I want to suspend X but not Y?', and if so how is it done? I
> > > ask because someone recently mentioned the spinning up and down of IDE
> > > during swsusp. That occurs because we can (AFAIK) only say suspend
> > > everything at the moment. It would be good if we could put to sleep
> > > everything except your system devices and the devices used to write
> > > the
> > 
> > Well, you need to suspend devices used to write the image, too, so you
> > have state to return to after resume. You only do not want disks to
> > spin down. Perhaps disk can just special-case it ("If I am going to
> > swsusp, I need to save state, but do not really need to spin down").
> 
> Mmm. Sounds ugly though. Would it be fair to say we want to S5 some
> devices and S3 others? Perhaps that sort of terminology might be
> helpful.

It does not sound too ugly to me. We want to do the same thing to all
devices: save their state. Then we save the image and power them down
(all of them).

Whether "normal" devices are powered before or after saving state is
unimportant detail.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
