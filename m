Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVIHVqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVIHVqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVIHVqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:46:34 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:4636 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S964945AbVIHVqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:46:33 -0400
Date: Thu, 8 Sep 2005 23:47:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consistently use the name asm-offsets.h
Message-ID: <20050908214741.GA16421@mars.ravnborg.org>
References: <20050908211539.GA24714@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908211539.GA24714@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mips has it own private gen-asm-offset macro,

The important part being:

sed -ne "/^@@@/s///p"; \

compared to the generic one:

sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \

I wonder why the assembly for mips is so different...
So for now two architectures needs special care: mips and ia64.

	Sam
