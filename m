Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265150AbSJaDPW>; Wed, 30 Oct 2002 22:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265146AbSJaDPW>; Wed, 30 Oct 2002 22:15:22 -0500
Received: from rth.ninka.net ([216.101.162.244]:3526 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265150AbSJaDPU>;
	Wed, 30 Oct 2002 22:15:20 -0500
Subject: Re: 2.5.45 CONFIG_INET=n broken due to secpath_put()
From: "David S. Miller" <davem@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021031022923.GA1313@compsoc.man.ac.uk>
References: <20021031022923.GA1313@compsoc.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 19:35:50 -0800
Message-Id: <1036035350.28188.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 18:29, John Levon wrote:
> core/skbuff.c:__kfree_skb() tries to do secpath_put(), which
> calls __secpath_destroy(), which is only built when CONFIG_INET=y

Once the IPSEC work dies down we'll figure out how to split things
out with config options and fix bugs like this one.

So just use CONFIG_INET=y for another week.

