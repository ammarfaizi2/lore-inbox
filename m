Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129229AbQKFNiD>; Mon, 6 Nov 2000 08:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129073AbQKFNhx>; Mon, 6 Nov 2000 08:37:53 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:43729 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129071AbQKFNht>; Mon, 6 Nov 2000 08:37:49 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 13:35:28 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A0698A8.8D00E9C1@mandrakesoft.com> <28752.973510632@redhat.com> <29788.973511264@redhat.com>
In-Reply-To: <29788.973511264@redhat.com>
MIME-Version: 1.0
Message-Id: <00110613370501.01541@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, David Woodhouse wrote:
> jgarzik@mandrakesoft.com said:
> > > * User continues to happily listen to radio through sound card
> > You're using the sound card without a driver?
> 
> Yes. The sound card allows itself to be unloaded when the pass-through mixer
> levels are non-zero. This is reasonable iff it can be reloaded without 
> destroying those levels again.
> 
> jgarzik@mandrakesoft.com said:
> >  If you create a post-action in /etc/modules.conf which initializes
> > the mixer to proper levels, this problem does not exist.
> 
> Yes it does. It can be a few seconds between initialisation and the 
> post-action running. That's plenty of time to miss what the news announcer 
> was saying about whether you need to go to work today (my gf is a teacher) 
> or to wake the entire house if the mixer levels don't default to zero.

So autoload the module with a "dont_screw_with_mixer" option. When the kernel
first boots, initialise the mixer to suitable settings (load the module with 
"do_screw_with_mixer" or whatever); thereafter, the driver shouldn't change
the mixer settings on load.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
