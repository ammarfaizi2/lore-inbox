Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVHAV41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVHAV41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVHAVyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:54:20 -0400
Received: from tim.rpsys.net ([194.106.48.114]:9710 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261285AbVHAVw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:52:27 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508011438010.7888@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 22:52:13 +0100
Message-Id: <1122933133.7648.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 14:40 -0700, Christoph Lameter wrote:
> Can you run kgdb on it to figure out what is going on?

Maybe, depending on how easily kgdb cross compiles and how quickly I can
learn to use it...

> There are some variables in /proc/vmstat that may help:
> 
> spurious_page_faults 0
> cmpxchg_fail_flag_update 0
> cmpxchg_fail_flag_reuse 0
> cmpxchg_fail_anon_read 0
> cmpxchg_fail_anon_write 0

In my case:

spurious_page_faults 0
cmpxchg_fail_flag_update 1359210189
cmpxchg_fail_flag_reuse 0
cmpxchg_fail_anon_read 0
cmpxchg_fail_anon_write 0

That number rapidly increases and so it looks like something is failing
and looping...

Richard

