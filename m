Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWANJua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWANJua (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWANJua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:50:30 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:58806 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751203AbWANJua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:50:30 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20060113173158.7696130c.akpm@osdl.org> (message from Andrew
	Morton on Fri, 13 Jan 2006 17:31:58 -0800)
Subject: Re: [PATCH 12/17] fuse: add connection aborting
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
	<20060114004118.605226000@dorka.pomaz.szeredi.hu> <20060113173158.7696130c.akpm@osdl.org>
Message-Id: <E1Exi2v-0004Cw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 14 Jan 2006 10:50:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >  	unsigned mounted : 1;
> >  	unsigned connected : 1;
> 
> Do these bitfields have locking?

Yes, these ones do have locking, but the others that follow don't,
which would cause similar problems.  I'll revise this part of the
code.

Thanks,
Miklos
