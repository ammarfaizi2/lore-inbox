Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTLNQ0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 11:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTLNQ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 11:26:25 -0500
Received: from ns.suse.de ([195.135.220.2]:51080 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262119AbTLNQ0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 11:26:24 -0500
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
References: <20031213022038.300B22C2C1@lists.samba.org.suse.lists.linux.kernel>
	<3FDAB517.4000309@cyberone.com.au.suse.lists.linux.kernel>
	<brgeo7$huv$1@gatekeeper.tmr.com.suse.lists.linux.kernel>
	<3FDBC876.3020603@cyberone.com.au.suse.lists.linux.kernel>
	<20031214043245.GC21241@mail.shareable.org.suse.lists.linux.kernel>
	<3FDC3023.9030708@cyberone.com.au.suse.lists.linux.kernel>
	<1071398761.5233.1.camel@laptop.fenrus.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2003 17:26:23 +0100
In-Reply-To: <1071398761.5233.1.camel@laptop.fenrus.com.suse.lists.linux.kernel>
Message-ID: <p73ad5vs6vk.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:
> 
> also keep in mind that current x86 processors all will internally
> optimize out the lock prefix in UP mode or when the cacheline is owned
> exclusive.... If HT matters here let the cpu optimize it out.....

Are you sure they optimize it out in UP mode? IMHO this would break
device drivers that use locked cycles to communicate with bus master
devices (and which are not necessarily mapped uncachable/write combining) 

-Andi
