Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVF2Vez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVF2Vez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVF2Vez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:34:55 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:33682 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262639AbVF2Vem convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:34:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G0pNHzNHAcY5W19EQQjBmSvrD4susmOQ1/SPAHsOqWaorXPAcO/UtzDRW1nyuxYyv7cb4Kaj2nymjF3FWcnk3i2suhAEW276lQzrnsU05NQJgjltoePLGjL6ccfcKUd0yfugHiY374KjMVsaEFJRbMYO4g6wYZ62jRkrxrxRxKc=
Message-ID: <8783be6605062914341bcff7cb@mail.gmail.com>
Date: Wed, 29 Jun 2005 17:34:41 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Hubert Chan <hubert@uhoreg.ca>
Subject: Re: reiser4 plugins
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <87hdfgvqvl.fsf@evinrude.uhoreg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <hubert@uhoreg.ca>
	 <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	 <87hdfgvqvl.fsf@evinrude.uhoreg.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/05, Hubert Chan <hubert@uhoreg.ca> wrote:
> On Wed, 29 Jun 2005 01:09:05 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:
> 
> > Hubert Chan <hubert@uhoreg.ca> wrote: [...]
> > And doing "tar cf /dev/tape /usr/games/tetris" gives you a nice tangle
> > of undecipherable junk.
> 

I'm confused.  Can someone on one of these lists enlighten me?

How is directories as files logically any different than putting all
data into .data files and making all files directories (yes you would
need some sort of special handling for files that were really called
.data).  Then it's just a matter of deciding what happens when you
call open and stat on one of these files?

For backwards compatibility, current existing system calls have to
treat these things as directories.  Perhaps an exception could be made
for exec.

But we could have a whole new set of system calls that treat things as
magic, and if files as directories is as cool as many people think,
apps will start using the new api.  If not, they won't and the new api
can be deprecated.

    Ross
