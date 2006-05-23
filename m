Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWEWVfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWEWVfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWEWVfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:35:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27860 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932292AbWEWVfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:35:15 -0400
Subject: Re: [Alsa-devel] Re: 2.6.17-rc4-mm3
From: Lee Revell <rlrevell@joe-job.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org
In-Reply-To: <6bffcb0e0605231407v11453f63t8b7335fd614ccdf9@mail.gmail.com>
References: <20060522022709.633a7a7f.akpm@osdl.org>
	 <6bffcb0e0605231407v11453f63t8b7335fd614ccdf9@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 23 May 2006 17:35:11 -0400
Message-Id: <1148420112.12529.169.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 23:07 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 22/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/
> >
> [snip]
> >  git-alsa.patch
> 
> I have noticed small problem with ALSA.
> When I boot 2.6.17-rc4-mm3 everything is ok, then I switch to
> 2.6.17-rc4-git11 - everything is ok. But when I switch back to
> 2.6.17-rc4-mm3 PCM is mute (off), Spread Front to Surround and
> Center/LFE is off, Channel Mode is set to 2ch (should be 6ch).
> 
> /sbin/alsactl -v
> alsactl version 1.0.11rc2
> 
> This is an user space tools bug?

If the mixer controls changed between those versions, then alsactl will
be unable to completely restore the mixer state.

Otherwise the problem is with your userspace tools.  I think KDE likes
to save/restore mixer settings on its own and its ALSA support is
horribly buggy.

It would help if you determine what app is saving/restoring the mixer
settings.

Lee


