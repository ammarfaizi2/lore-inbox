Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753870AbWKFWUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbWKFWUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbWKFWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:20:34 -0500
Received: from pm-mx9.mgn.net ([195.46.220.205]:43747 "EHLO pm-mx9.mgn.net")
	by vger.kernel.org with ESMTP id S1753870AbWKFWUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:20:32 -0500
From: Damien Wyart <damien.wyart@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, James@superbug.demon.co.uk
Subject: Re: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
References: <20061102102607.GA2176@localhost.localdomain>
	<20061102192607.GA13635@kroah.com> <878xitpkvy.fsf@brouette.noos.fr>
	<20061102222242.GA17744@kroah.com> <s5hvelsfv1g.wl%tiwai@suse.de>
Date: Mon, 06 Nov 2006 18:30:31 +0100
In-Reply-To: <s5hvelsfv1g.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon\,
	06 Nov 2006 16\:34\:51 +0100")
Message-ID: <87wt68a3ew.fsf@brouette.noos.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.90
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Takashi Iwai <tiwai@suse.de> [061106 16:34]:
> Well, I've not checked the problem in detail yet (since I'm back from
> vacation), but my rough guess is that snd_card_register() is indeed
> called multiple times. It's correct behavior as this function is
> supposed to be callable multiple times. Some components (like
> emux-synth) are implemented as a kind of "plug-in", and they call
> snd_card_register() to assure that the underlying card tree gets
> ready.

> A simple fix would be like below.  Could you give it a try?

Yes, with with patch the offending message disappears from the bootlog.
Thanks for your answer!

-- 
Damien
