Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNOHQ>; Wed, 14 Feb 2001 09:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNOHH>; Wed, 14 Feb 2001 09:07:07 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:18201 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129051AbRBNOG6>; Wed, 14 Feb 2001 09:06:58 -0500
Date: Wed, 14 Feb 2001 16:06:49 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Simon Kirby <sim@netnation.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: LDT allocated for cloned task!
Message-ID: <20010214160649.D11083@niksula.cs.hut.fi>
In-Reply-To: <20010213124226.A15600@stormix.com> <E14Sk5t-0002Sl-00@the-village.bc.nu> <20010213104823.A14060@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010213104823.A14060@netnation.com>; from sim@netnation.com on Tue, Feb 13, 2001 at 10:48:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 10:48:23AM -0800, you [Simon Kirby] claimed:
> On Tue, Feb 13, 2001 at 06:22:26PM +0000, Alan Cox wrote:
> 
> > > LDT allocated for cloned task!
> > > 
> > > I'm seeing this message come up fairly often while running vanilla
> > > 2.4.2-pre3 on my dual Celeron system.  I don't think I saw it before
> > > while running 2.4.1, but I may have just missed it.
> > 
> > Are you running wine or dosemu ?
> 
> Actually, I've ran both of them at least a few times this boot.
> 
> I think I've found what's doing it...xmms with the avi-xmms plugin will
> cause the message to appear at startup even without playing anything. 
> Moving the libraries out of the /usr/lib/xmms/Input directory and
> starting xmms again will not produce any message.  I only just recently
> downloaded this plugin which is probably why I didn't see it before.
> 
> It's also happening on my second (non-DRI) head, so it's probably not
> related to that (I'll reboot and try again without any DRI modules loaded
> and see).

I saw/see a lot of those messages on 2.2.18pre19 as well. I hacked the
kernel to show the process in question, and it's always xmms:

LDT allocated for cloned task (pid=20272; count=3)!

20272 pts/10   RN   186:01 xmms

And I do have the xmms-avi plugin in the plugin directory. So if you find a
bug/fix to 2.4, could you please check 2.2 as well? (I'm afraid I'm not
nearly clueful enough.) 

Are these messages serious anyway?


-- v --

v@iki.fi
