Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUGRHeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUGRHeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 03:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUGRHeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 03:34:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:42983 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262906AbUGRHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 03:34:17 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] was: [RFC] removal of sync in panic
Date: Sun, 18 Jul 2004 09:34:12 +0200
User-Agent: KMail/1.6.2
Cc: Tim Wright <timw@splhi.com>, Andrew Morton <akpm@osdl.org>, lmb@suse.de
References: <200407141745.47107.linux-kernel@borntraeger.net> <200407150658.54925.linux-kernel@borntraeger.net> <1090090902.14032.15.camel@kryten.internal.splhi.com>
In-Reply-To: <1090090902.14032.15.camel@kryten.internal.splhi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407180934.12418.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright wrote:
> Yes, I've seen this multiple times.
> I also agree that it seems a sensible patch. I have one dumb question.
> Given that we're panicing and we know things are "bad", is there any
> reason not to call smp_send_stop() as early as possible, rather than as
> the last thing which we currently do? As you say, the other cpus are
> happily continuing, potentially destroying data, and it seems that
> stopping this as quickly as possible would be desirable.

That suggestion was my number 2 is my first mail :-)

On the other hand, if we remove the sync stuff,  smp_send_stop is called 
quite early. Only a printf is called before smp_send_stop().  
