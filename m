Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWI2XTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWI2XTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWI2XTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:19:35 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:62916 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1750830AbWI2XTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:19:33 -0400
Date: Fri, 29 Sep 2006 16:18:49 -0700
To: Dave Jones <davej@redhat.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Message-ID: <20060929231849.GB10423@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com> <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com> <20060929222410.GI22014@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929222410.GI22014@redhat.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 06:24:10PM -0400, Dave Jones wrote:
> On Sat, Sep 30, 2006 at 12:04:31AM +0200, Alessandro Suardi wrote:
> 
>  > Even if so, wireless-tools would be the only package I have to
>  >  build out of the FC5 distribution to keep up with the latest -git
>  >  snapshot of the Torvalds kernel... I'm not especially troubled
>  >  with this anyway. Perhaps you could push the Fedora folks to
>  >  be a bit more up-to-date with wireless-tools in their current
>  >  main version ?
> 
> We do. Frequently, because it tends to break in some manner every
> single time we push a rebased kernel update.
> wireless-tools v28 is in the updates repo right now, which afaik, is
> already the newest available.

	Correct.

> It's seriously unfunny to have to update fundamental userspace packages
> like this when moving to a newer kernel. Especially when say for eg,
> the newer kernel then has a broken sound driver, so the user goes
> back to their old 'working' kernel. Oops, now they have a choice
> of a kernel with broken sound, or a kernel with broken wireless.

	I'm 100% with you Dave.
	The ESSID change was pretty much forced on me. You can check
the thread on this mailing list starting around 27th of January. Jouni
and Dan were ones of the main advocate of this change. The main reason
is that half of the driver were doing the old way, and the other half
the new way, so we needed to bring back consistency.
	I pushed WT-28 just after the wireless summit, when this
change was reconfirmed, so that it had time to percolate in the
distro. WT-28 works with both kernel before and after the changeover,
so it's transparent. As I say, most distro have it in their dev
version for already some time (even Slackware).
	At the same time, I also looked at other userspace apps. I
looked personally at the source code, and most apps were not affected,
because they wrap around iwconfig or never SET the ESSID.
	The main apps that were affected are wpa_supplicant and
xsupplicant. I told Jouni about required change in wpa_supplicant as
early as 15 March, and reminded him later.
	In other words, I believe I did everything I could do to make
the transition smooth and transparent on userspace. If you think I
could have done better, please tell me. Of course, there are always
people using bleeding edge kernel in old distro, but in theory they
are able to interpret the warning given to them by the Wireless Tools.

> 	Dave

	Have fun...

	Jean
