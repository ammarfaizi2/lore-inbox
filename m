Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTLKU73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTLKU72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:59:28 -0500
Received: from gaia.cela.pl ([213.134.162.11]:38155 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261368AbTLKU72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:59:28 -0500
Date: Thu, 11 Dec 2003 21:58:54 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 + tmpfs: where's my mem?!
In-Reply-To: <yw1x3cbrh1qn.fsf@kth.se>
Message-ID: <Pine.LNX.4.44.0312112157540.9700-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, I've seen this behavior with vmware 4.  The space came back when
> I closed vmware.

Vmware creates tmp files, deletes them, but keeps them open - the space is 
used until all the file descriptors are closed.  See if lsof doesn't show 
some /tmp files which are open and large.

Cheers,
MaZe.


