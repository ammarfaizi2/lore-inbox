Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965360AbWAGACl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbWAGACl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965362AbWAGACk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:02:40 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:4580 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S965360AbWAGACj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:02:39 -0500
Date: Fri, 6 Jan 2006 16:00:48 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Bob Copeland <email@bobcopeland.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chuck Ebbert <76306.1226@compuserve.com>, Dave Jones <davej@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dual line backtraces for i386.
Message-ID: <20060107000048.GH84622@gaz.sfgoth.com>
References: <200601061338_MC3-1-B567-4FDD@compuserve.com> <Pine.LNX.4.61.0601062016550.28630@yvahk01.tjqt.qr> <b6c5339f0601061133r3653af33h89a0ad7b44f5f94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c5339f0601061133r3653af33h89a0ad7b44f5f94a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 06 Jan 2006 16:00:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Copeland wrote:
> Sure: if you use '\t' then you can do:
> 
> printk("%c", 9+space++);
> space &= 1;

Please...

	char space = '\t';
	[...]
	printk("%c", space);
	space = ('\t' + '\n') - space;

Even fewer instructions and actually somewhat understandable.

-Mitch
