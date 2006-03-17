Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWCQMT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWCQMT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWCQMT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:19:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:63172 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932083AbWCQMT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:19:28 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: drivers/net/chelsio/sge.c: two array overflows
Date: Fri, 17 Mar 2006 13:19:19 +0100
User-Agent: KMail/1.8
Cc: Scott Bardone <sbardone@chelsio.com>, Adrian Bunk <bunk@stusta.de>,
       maintainers@chelsio.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060311013720.GG21864@stusta.de> <4415C87B.90107@chelsio.com> <441A011A.6010705@pobox.com>
In-Reply-To: <441A011A.6010705@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603171319.20935.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[from the nitpick department..]

Hi Jeff, hi Scott,

Adrian wrote:
>The Coverity checker spotted the following two array overflows in 
>drivers/net/chelsio/sge.c (in both cases, the arrays contain 3 
>elements):

Am Freitag, 17. März 2006 01:21 schrieb Jeff Garzik:
> Scott Bardone wrote:
> > Adrian,
> >
> > This is a bug. The array should contain 2 elements.
> >
> > Attached is a patch which fixes it.
> > Thanks.
> >
> > Signed-off-by: Scott Bardone <sbardone@chelsio.com>
>
> applied.  please avoid attachments and use a proper patch description
> in the future.  I had to hand-edit and hand-apply your patch.

where you wrote in kernel tree commit 
347a444e687b5f8cf0f6485704db1c6024d3:
This is a bug. The array should contain 2 elements.  Here is the fix.

If I'm not completely off the track, you both committed a description 
off by one error: since the patch doesn't change the array size, it's 
presumely¹ still 3 elements, where index 2 references the last one.

Here's hopefully a better patch description:
Fixed off by one thinko in stats accounting, spotted by Coverity 
checker, notified by Adrian "The Cleanman" Bunk.

SCR,
Pete

¹) otherwise, it's still off by one..
