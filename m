Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVF2AVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVF2AVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVF2ANB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:13:01 -0400
Received: from nome.ca ([65.61.200.81]:45755 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S262311AbVF2AMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:12:44 -0400
Date: Tue, 28 Jun 2005 17:12:44 -0700
From: Mike Bell <kernel@mikebell.org>
To: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050629001243.GD4673@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org> <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com> <20050628090852.GA966@mikebell.org> <1119950487.3175.21.camel@laptopd505.fenrus.org> <20050628214929.GB23980@voodoo> <20050628222318.GC4673@mikebell.org> <20050628234310.GA29653@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628234310.GA29653@mail>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 07:43:10PM -0400, Jim Crilly wrote:
> Well it looks like the ALSA library already abstracts the device node
> enough that the app itself doesn't know what file is being used because it
> just calls snd_card_get_name, snd_open_pcm, etc with the ALSA index. So
> wouldn't it be feasible to make ALSA a little bit smarter so that it could
> track/find the device nodes no matter what name they have?

You could in theory do that to ALSA. Except for the aforementioned
"how?". How is ALSA supposed to find out what its new device node name
is? You could invent some sort of crazy libudev, but I think it would
require a major redesign of how udev works, forcing it to keep state or
such. The only alternatives I can see are what I already mentioned,
searching every single device node in /dev to find the right one.

Which is why I conclude (and, evidently, Greg agrees) that consistent
naming schemes for /dev are very important. Now if I could just find out
why devfs's failure to allow such broken configurations is a bug in his
mind. :)
