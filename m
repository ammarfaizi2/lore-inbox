Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVBUQzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVBUQzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVBUQzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:55:21 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:32196 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262040AbVBUQzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:55:12 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
Date: Mon, 21 Feb 2005 17:55:00 +0100
User-Agent: KMail/1.7.1
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Jay Lan <jlan@engr.sgi.com>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr> <20050221035808.48401cd2.pj@sgi.com> <1108997033.8418.193.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1108997033.8418.193.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502211755.00795.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 February 2005 15:43, Guillaume Thouvenin wrote:
> 
>   I also choose this implementation because Erich Focht wrote in the
> email http://lkml.org/lkml/2004/12/17/99 that keeps the historic about
> the creation of processes "sounds very useful for a lot of interesting
> stuff". So I thought about something that can be used by other
> application and with netlink, information is available to everyone. 

Besides accounting I had in mind something like cluster-wide pid
tracking in userspace with builtin relationship information. A bit of
single system image integration... As I don't have it, yet, I'm not
(yet) a very strong requester for the service provided by your
module. But I still think it's usefull and might want later a hook on
exit, too. (And yes, I can imagine of other ways to get the data
effectively out of the kernel, too).

> Results are:
> 
>   kernel without fork connector
>     real : 8m17.042s 8m10.113s 8m08.597s 8m10.068s 8m08.930s
>     user : 7m32.376s 7m35.985s 7m34.424s 7m34.221s 7m34.835s
>     sys  : 0m50.730s 0m51.139s 0m51.159s 0m51.406s 0m51.020s    
> 
>   kernel with the fork connector
>     real : 8m14.492s 8m08.656s 8m07.754s 8m08.002s 8m07.854s
>     user : 7m31.664s 7m33.528s 7m33.625s 7m33.500s 7m33.822s
>     sys  : 0m50.651s 0m51.222s 0m51.102s 0m51.367s 0m50.894s
>    
>   kernel with the fork connector + application listens
>     real : 8m08.596s 8m08.950s 8m08.899s 8m08.678s 8m08.987s
>     user : 7m33.312s 7m33.898s 7m34.004s 7m33.285s 7m33.628s
>     sys  : 0m52.222s 0m52.013s 0m51.809s 0m52.361s 0m52.036s

I liked the previous lean implementation more, but the performance
of this one doesn't look at all as scary as I thought.

Best regards,
Erich

