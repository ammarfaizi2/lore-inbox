Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbTIIGYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 02:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTIIGYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 02:24:37 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:57005 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S262204AbTIIGYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 02:24:36 -0400
Date: Mon, 8 Sep 2003 23:24:32 -0700
Message-Id: <200309090624.h896OWe21912@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, mingo@redhat.com,
       drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
In-Reply-To: Andrew Morton's message of  Monday, 8 September 2003 19:12:15 -0700 <20030908191215.22f501a2.akpm@osdl.org>
X-Zippy-Says: I want another RE-WRITE on my CAESAR SALAD!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it make sense to do this via
> 
> 	if (is_orphaned_pgrp(process_group(current)))
> 
> and to then rename task_struct.pgrp to something else, to pick up any
> missed conversions?

I am wholly in favor of this.  I think what we really want to do is move
pgrp into signal_struct, and that would be painless after the macroization. 


Thanks,
Roland
