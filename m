Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314393AbSEFLsG>; Mon, 6 May 2002 07:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314394AbSEFLsF>; Mon, 6 May 2002 07:48:05 -0400
Received: from gate.perex.cz ([194.212.165.105]:35854 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S314393AbSEFLsE>;
	Mon, 6 May 2002 07:48:04 -0400
Date: Mon, 6 May 2002 13:46:57 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Christoph Hellwig <hch@infradead.org>
cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.14 OSS emulation
In-Reply-To: <20020506123035.A26941@infradead.org>
Message-ID: <Pine.LNX.4.33.0205061346110.488-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Christoph Hellwig wrote:

> On Mon, May 06, 2002 at 01:14:40PM +0200, Pierre Rousselet wrote:
> >  From ChangeLog-2.5.14 :
> > 
> > <hch@infradead.org> (02/05/05 1.545)
> > 	[PATCH] fix config.in syntax errors.
> >         - sound uses a bool where it should use a dep_bool
> > 
> > This prevents using OSS emulation with ALSA drivers. What is the reason 
> > behind ?
> 
> 2.4.13 used to do (in sound/core/Config.in):
> 
> bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND
> 
> The bool verb take exaxctly two arguments, the option description
> and the config option itself, if you want additional depencies you
> have to use dep_bool instead.
> 
> If this fix breaks ALSA it only shows that it has even deeper config
> problems - I don't use ALSA and care only about the syntactical
> correctness of that file.

The correct fix should be:

bool '  OSS API emulation' CONFIG_SND_OSSEMUL

I'm sorry about that.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

