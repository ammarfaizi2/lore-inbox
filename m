Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWCZWkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWCZWkx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWCZWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:40:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14350 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932152AbWCZWkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:40:52 -0500
Date: Wed, 22 Mar 2006 23:26:39 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
Message-ID: <20060322232638.GA2375@ucw.cz>
References: <200603232151.47346.ncunningham@cyclades.com> <20060323040649.3a6c96f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323040649.3a6c96f1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gi!

> > At the moment libata doesn't pass pm_message_t down ata_device_suspend.
> >  This causes drives to be powered down when we just want a freeze,
> >  causing unnecessary wear and tear. This patch gets pm_message_t passed
> >  down so that it can be used to determine whether to power down the
> >  drive.
> 
> Does this explain http://bugzilla.kernel.org/show_bug.cgi?id=6264 ?
> 
> This might be 2.6.16.1 material - how irritating is it?

I'd say patch is okay for mainline, but not worth it for 2.6.16.1 ---
we have lived with similar problem for quite a long time for PATA.


-- 
Thanks, Sharp!
