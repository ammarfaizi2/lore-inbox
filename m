Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVH2PAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVH2PAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVH2PAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:00:17 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:36041 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750969AbVH2PAP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:00:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bV0NUtQykjot9+9mbtsiozLQviWclOB3VnDD947DHlDySHVD0OrpClKTx5Zj/vESV33o5iYLiyvVh8koaMhhPvkDJQSoQwUtIU/fraQzgFoSyNg5FaHJuBsDpgHEByKkEX6/1zX6PkmhW47Rm5r0OHYrqkeK8rG3yYZtG/afneY=
Message-ID: <9a8748490508290800bba68c1@mail.gmail.com>
Date: Mon, 29 Aug 2005 17:00:14 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Pete Popov <ppopov@mvista.com>
Subject: Re: [PATCH 2/3] exterminate strtok - drivers/video/au1100fb.c
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1125326968.6104.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508242108.32885.jesper.juhl@gmail.com>
	 <1124950581.14435.978.camel@localhost.localdomain>
	 <9a8748490508290443ab7cd62@mail.gmail.com>
	 <1125326968.6104.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/05, Pete Popov <ppopov@mvista.com> wrote:
> On Mon, 2005-08-29 at 13:43 +0200, Jesper Juhl wrote:
> > On 8/25/05, Pete Popov <ppopov@mvista.com> wrote:
> > >
> > > I see the patch, or an equivalent, has been applied already.
> > >
> > Ohh, where? I don't see such a patch in 2.6.12-rc6-mm2 nor in 2.6.13.
> 
> 2.6.13.
> 
Then I must be blind, because I still see the old strtok() using code
in there :

juhl@dragon:~/download/kernel/linux-2.6.13$ head -n 5 Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 13
EXTRAVERSION =
NAME=Woozy Numbat
juhl@dragon:~/download/kernel/linux-2.6.13$ grep -A 1 strtok
drivers/video/au1100fb.c
        for(this_opt=strtok(options, ","); this_opt;
            this_opt=strtok(NULL, ",")) {
                if (!strncmp(this_opt, "panel:", 6)) {

And the patch I created still applies just fine.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
