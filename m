Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSEFLam>; Mon, 6 May 2002 07:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSEFLal>; Mon, 6 May 2002 07:30:41 -0400
Received: from imladris.infradead.org ([194.205.184.45]:34056 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314381AbSEFLal>; Mon, 6 May 2002 07:30:41 -0400
Date: Mon, 6 May 2002 12:30:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: hch@infradead.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.14 OSS emulation
Message-ID: <20020506123035.A26941@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD665A0.2030508@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 01:14:40PM +0200, Pierre Rousselet wrote:
>  From ChangeLog-2.5.14 :
> 
> <hch@infradead.org> (02/05/05 1.545)
> 	[PATCH] fix config.in syntax errors.
>         - sound uses a bool where it should use a dep_bool
> 
> This prevents using OSS emulation with ALSA drivers. What is the reason 
> behind ?

2.4.13 used to do (in sound/core/Config.in):

bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND

The bool verb take exaxctly two arguments, the option description
and the config option itself, if you want additional depencies you
have to use dep_bool instead.

If this fix breaks ALSA it only shows that it has even deeper config
problems - I don't use ALSA and care only about the syntactical
correctness of that file.

