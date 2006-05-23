Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWEWVva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWEWVva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWEWVva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:51:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:51031 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932289AbWEWVv3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:51:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IOQYLBV5qaSqzWQJt7umVbNNQwGnXBBmHd1szXg0ZKDHkcfclqn6VZHtL4ogwF7KYlNqiUZRmRwsVxBaCHxna8VdOo7Ie8YTCoyoJmZ5ew/hWflLu3SZvXS8YG3fXNyqb0/eO4qj2RB/nbiMh3ado6XfbgBqkei6GXA7N4QZass=
Message-ID: <6bffcb0e0605231451x1ddc3886nb1be17196bcbf52f@mail.gmail.com>
Date: Tue, 23 May 2006 23:51:28 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: 2.6.17-rc4-mm3
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <1148420112.12529.169.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060522022709.633a7a7f.akpm@osdl.org>
	 <6bffcb0e0605231407v11453f63t8b7335fd614ccdf9@mail.gmail.com>
	 <1148420112.12529.169.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
On 23/05/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2006-05-23 at 23:07 +0200, Michal Piotrowski wrote:
> > Hi,
> >
> > On 22/05/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/
> > >
> > [snip]
> > >  git-alsa.patch
> >
> > I have noticed small problem with ALSA.
> > When I boot 2.6.17-rc4-mm3 everything is ok, then I switch to
> > 2.6.17-rc4-git11 - everything is ok. But when I switch back to
> > 2.6.17-rc4-mm3 PCM is mute (off), Spread Front to Surround and
> > Center/LFE is off, Channel Mode is set to 2ch (should be 6ch).
> >
> > /sbin/alsactl -v
> > alsactl version 1.0.11rc2
> >
> > This is an user space tools bug?
>
> If the mixer controls changed between those versions, then alsactl will
> be unable to completely restore the mixer state.
>
> Otherwise the problem is with your userspace tools.  I think KDE likes
> to save/restore mixer settings on its own and its ALSA support is
> horribly buggy.
>
> It would help if you determine what app is saving/restoring the mixer
> settings.

This is from my /etc/init.d/halt (FC5)
if [ $? = 0 -a -x /usr/sbin/alsactl ]; then
   runcmd $"Saving mixer settings" alsactl store
fi

but this is KDE problem :).

> Lee

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
