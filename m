Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271739AbTHDNhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271740AbTHDNhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:37:36 -0400
Received: from deepthought.resolution.de ([195.30.142.42]:37327 "EHLO
	deepthought.resolution.de") by vger.kernel.org with ESMTP
	id S271739AbTHDNhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:37:35 -0400
Message-ID: <1060004221.3f2e617d72d4f@corporate.resolution.de>
Date: Mon,  4 Aug 2003 15:37:01 +0200
From: Christian Reichert <c.reichert@resolution.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: =?iso-8859-1?b?TeVucyA=?= =?iso-8859-1?b?UnVsbGflcmQ=?= 
	<mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com> <yw1xsmohioah.fsf@users.sourceforge.net> <20030804152226.60204b61.skraw@ithnet.com>
In-Reply-To: <20030804152226.60204b61.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 192.147.51.120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

the fundamental problem as i know it is that the FS design in unix is based on 
a directory TREE structure - however if you implement hard links for 
directories you are breaking this strict treeu structure and can end up with 
loops/graphs.

(What are the cases where a symlink wouldn't be enough ?)

Cheers,

    Chris


Zitat von Stephan von Krawczynski <skraw@ithnet.com>:

> On Mon, 04 Aug 2003 14:45:58 +0200
> mru@users.sourceforge.net (Måns Rullgård) wrote:
> 
> > Stephan von Krawczynski <skraw@ithnet.com> writes:
> > 
> > > although it is very likely I am entering (again :-) an ancient
> > > discussion I would like to ask why hardlinks on directories are not
> > > allowed/no supported fs action these days. I can't think of a good
> > > reason for this, but can think of many good reasons why one would
> > > like to have such a function, amongst those:
> > 
> > I don't know the exact reasons it isn't allowed, but you can always
> > use "mount --bind" to get a similar effect.
> 
> I guess this is not really an option if talking about hundreds or thousands
> of
> "links", is it?
> 
> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



