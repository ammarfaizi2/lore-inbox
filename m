Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTITIKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 04:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbTITIKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 04:10:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50362 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261659AbTITIKn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 04:10:43 -0400
Date: Sat, 20 Sep 2003 00:58:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: dychen@stanford.edu, linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       netdev@oss.sgi.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-Id: <20030920005811.09f12e07.davem@redhat.com>
In-Reply-To: <20030916090748.GE27703@wohnheim.fh-wedel.de>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
	<20030916090748.GE27703@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 11:07:48 +0200
Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Looks valid.  And since skb isn't really needed until after these
> returns, moving four lines down a bit fixes the problem.
> 
> Davem, is this correct?

Nope, now you're leaking the route instead of the SKB :-)

I'll put the correct fix in.
