Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTEaHrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTEaHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:47:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60341 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264199AbTEaHrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:47:24 -0400
Date: Sat, 31 May 2003 00:59:09 -0700 (PDT)
Message-Id: <20030531.005909.68051039.davem@redhat.com>
To: joern@wohnheim.fh-wedel.de
Cc: jmorris@intercode.com.au, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030531075615.GA25089@wohnheim.fh-wedel.de>
References: <20030531064851.GA20822@wohnheim.fh-wedel.de>
	<20030530.235505.23020750.davem@redhat.com>
	<20030531075615.GA25089@wohnheim.fh-wedel.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jörn Engel <joern@wohnheim.fh-wedel.de>
   Date: Sat, 31 May 2003 09:56:15 +0200

   On Fri, 30 May 2003 23:55:05 -0700, David S. Miller wrote:
   > You'll need to disable preemption.
   
   My gut feeling claims that this would hurt interactivity.

You can't leave the per-cpu workspace in an indeterminate
state, you'll context switch and meanwhile that workspace will
be used by another client or you'll next get scheduled on
a different cpu and use a different workspace.
