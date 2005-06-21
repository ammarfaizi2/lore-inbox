Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVFVAAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVFVAAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVFUX5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:57:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35306 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262307AbVFUXzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:55:47 -0400
Date: Wed, 22 Jun 2005 01:55:40 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
Message-ID: <20050621235540.GK14251@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230A4046AA@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A4046AA@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 03:50:48PM -0700, YhLu wrote:
> I would like to help. Can you say more detail ? I don't know how to souce
> code tracing statement....

> 
> Do you mean setup one global buffer, and in the setup.c compare the node id
> or node id to decide to write sth to the buffer, and print out when the cpu0
> get the control again?

Yes. You can just use a global variable because the smp bootup is essentially
single threaded. printk would destroy the timing though.

Start with the code that prints ExtInt enabled. 

Writ current_text_address() into a buffer and dump it then on CPU #0
after some timeout (hopefully it is still alive) 

If you have problems mail me and I will write you a tracing patch
tomorrow.

-Andi
