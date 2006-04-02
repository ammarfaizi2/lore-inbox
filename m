Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWDBOsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWDBOsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWDBOsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:48:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51389 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932349AbWDBOsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:48:24 -0400
Subject: Re: [PATCH] Add prctl to change endian of a task
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604021637.49759.ioe-lkml@rameria.de>
References: <20060401222921.GI23416@krispykreme>
	 <200604021637.49759.ioe-lkml@rameria.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Apr 2006 15:56:09 +0100
Message-Id: <1143989770.29060.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-04-02 at 16:37 +0200, Ingo Oeser wrote:
> What about limiting this to be called once per task or VM?
> This will prevent most abuse scenarios, I can think of.

Abuse is a possible problem but you can deal with that. If you don't
inherit endian changes then the problem doesn't occur. If you must
inherit them then drop the inheritance when an suid/sgid exec occurs as
we do with some other properties.

Can you explain however why you can't do this simply by using a binary
magic number in the executable to indicate which endian it is, or do you
really need to flip it ?

Alan

