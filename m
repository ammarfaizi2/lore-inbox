Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUIOU4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUIOU4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUIOUzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:55:21 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:46399 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267433AbUIOUxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:53:35 -0400
Subject: Re: PATCH: tty locking for 2.6.9rc2
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040915204028.GA25740@devserv.devel.redhat.com>
References: <20040914163426.GA29253@devserv.devel.redhat.com>
	 <1095265595.2924.27.camel@deimos.microgate.com>
	 <20040915163051.GA9096@devserv.devel.redhat.com>
	 <1095274482.2686.16.camel@deimos.microgate.com>
	 <20040915200856.GA8000@devserv.devel.redhat.com>
	 <1095279799.2958.11.camel@deimos.microgate.com>
	 <20040915204028.GA25740@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095281599.2958.21.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Sep 2004 15:53:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 15:40, Alan Cox wrote:
> What do you think about
> 
> 	tty_ldisc_get(tty, ldisc_num)
> 
> That seems to remove the whole mess ?

Seems reasonable.
It's more compact and less error prone.

It will require some reordering/reworking
of tty_set_ldisc().

 
--
Paul Fulghum
paulkf@microgate.com


