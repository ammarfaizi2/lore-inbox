Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUIENtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUIENtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUIENtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:49:15 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:46086 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266705AbUIENtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:49:08 -0400
Date: Sun, 5 Sep 2004 14:49:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dan Kegel <dank@kegel.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Getting kernel.org kernel to build for m68k?
Message-ID: <20040905144904.A30552@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Kegel <dank@kegel.com>, Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
References: <41355F88.2080801@kegel.com> <Pine.GSO.4.58.0409011029390.15681@waterleaf.sonytel.be> <Pine.LNX.4.58.0409051224020.30282@anakin> <20040905120325.A29363@infradead.org> <20040905131948.GE2605@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040905131948.GE2605@kiste>; from smurf@smurf.noris.de on Sun, Sep 05, 2004 at 03:19:48PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 03:19:48PM +0200, Matthias Urlichs wrote:
> Hi,
> 
> Christoph Hellwig:
> > > Hence if no one objects, I'll submit the patch to Andrew and Linus.
> > 
> > the common code changes below are not okay.
> 
> Why not?

Because we don't want gazillions of special cases in common code.  We
already added support for allocating the thread_info and task_struct
as a single object because ia64 needed it, there's no reason to stack
another hack ontop for m68k.

