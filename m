Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWALAe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWALAe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWALAe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:34:26 -0500
Received: from [81.2.110.250] ([81.2.110.250]:52651 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964859AbWALAeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:34:25 -0500
Subject: Re: [PATCH] new tty buffering access fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20060111160823.6bc95ab8.akpm@osdl.org>
References: <1137023508.3113.10.camel@x2.pipehead.org>
	 <20060111160823.6bc95ab8.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Jan 2006 00:37:13 +0000
Message-Id: <1137026233.16399.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-11 at 16:08 -0800, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> >  Fix typos in new tty buffering that incorrectly
> >  access and update buffers in pending queue.
> 
> Curious.  How did this manage to sneak through without anyone noticing? 
> Does tty_buffer_request_room() mostly work, or do only rarely-used drivers
> use it, or what?

Bit of both. It works unless you use request_room _and_ queue buffers
very fast. Most drivers do neither some do one only, but fortunately
Paul did both

