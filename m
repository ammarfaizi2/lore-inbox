Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVAYTsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVAYTsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVAYTsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:48:24 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:55823 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262108AbVAYTqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:46:51 -0500
Date: Tue, 25 Jan 2005 20:46:47 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: dtor_core@ameritech.net
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-input@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i8042 access timings
Message-ID: <20050125194647.GB3494@pclin040.win.tue.nl>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000501251117120a738a@mail.gmail.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: pastinakel.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:17:33PM -0500, Dmitry Torokhov wrote:

> Still, I wonder if implementing these delays will give IO controller
> better chances to react to our queries and will get rid of some
> failures.

My objection is this: by doing this you create myths that may
be difficult to dispel later. I recall other situations where
there were superfluous restrictions and I had a hard time convincing
others of the fact that the tests weren't there for any good reason,
that there was no single instance of hardware on earth known to
work better with the added restrictions.

So, I would prefer to only insert delays if at least one person
reports that things improve if you do so. Or if you can point at
data sheets that state that such delays are needed.
Or perhaps if you can show that there were delays in 2.4 absent in 2.6.

Apart from the "not creating myths" reason, there is another:
as we know, the keyboard/mouse system is in a bad state in 2.6.
It often happens that 2.6.x works and 2.6.y fails, and we ask a user
to try intermediate stages to see what change made a difference.
Applying random meaningless patches to the keyboard system creates
additional noise and uncertainty.

Andries
