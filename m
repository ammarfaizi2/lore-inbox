Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWIJUDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWIJUDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWIJUDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:03:49 -0400
Received: from nef2.ens.fr ([129.199.96.40]:19985 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964842AbWIJUDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:03:48 -0400
Date: Sun, 10 Sep 2006 22:03:37 +0200
From: David Madore <david.madore@ens.fr>
To: Joshua Brindle <method@gentoo.org>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060910200337.GA24123@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450451DB.5040104@gentoo.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 22:03:37 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 01:56:43PM -0400, Joshua Brindle wrote:
> To expand on this a little, some of the capabilities you are looking to 
> add are of very little if any use without being able to specify objects. 
> For example, CAP_REG_OPEN is whether the process can open any file 
> instead of specific ones. How many applications open no files whatsoever 
> in practice? Even if there are some as soon as they change and need to 
> open a file they'll need this capability and will be able to open any. 
> CAP_REG_WRITE has the same problem. For a description of why 
> CAP_REG_EXEC is meaningless see the digsig thread on the LSM list from 
> earlier this year.

CAP_REG_OPEN and CAP_REG_EXEC might be useful only for demonstration
purposes, but I've *often* wished I could run a program without
CAP_REG_WRITE because I wasn't root and I wanted to make *sure* it
didn't write any file anywhere.  Instead I had to run them from a
user-mode-linux, which is horribly messy and doesn't work well (and,
at best, with a noticeable slowdown).

Again, I ask: is SElinux useable if you aren't root?  (Assuming it's
activated, of course: I mean, can you create new policies to make
certain programs run with restricted privileges?)  I thought it
wasn't, but maybe I'm wrong.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
