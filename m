Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbTAXThC>; Fri, 24 Jan 2003 14:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTAXThC>; Fri, 24 Jan 2003 14:37:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3052 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264657AbTAXThB>;
	Fri, 24 Jan 2003 14:37:01 -0500
Date: Fri, 24 Jan 2003 11:34:51 -0800 (PST)
Message-Id: <20030124.113451.108343849.davem@redhat.com>
To: jgarzik@pobox.com
Cc: ink@jurassic.park.msu.ru, willy@debian.org, linux-kernel@vger.kernel.org,
       Jeff.Wiedemeier@hp.com
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030124193135.GA30884@gtf.org>
References: <20030124212748.C25285@jurassic.park.msu.ru>
	<20030124193135.GA30884@gtf.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Fri, 24 Jan 2003 14:31:35 -0500

   So, the above patch is probably the wrong thing to do.  I'll need to
   check to be sure, but I think that h/w reset clears MSGINT_MODE_ENABLE,
   so we wouldn't want to be randomly enabling it when it is purposefully
   disabled.
   
   DaveM/Jeff, corrections?
   
You're right Jeff, I hadn't noticed the forced enabling of MSI, that
is totally wrong.
