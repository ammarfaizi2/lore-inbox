Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSK0IBx>; Wed, 27 Nov 2002 03:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSK0IBx>; Wed, 27 Nov 2002 03:01:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26265 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261463AbSK0IBx>;
	Wed, 27 Nov 2002 03:01:53 -0500
Date: Wed, 27 Nov 2002 00:06:40 -0800 (PST)
Message-Id: <20021127.000640.26928230.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: sfr@canb.auug.org.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       anton@samba.org, ak@muc.de, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15844.31669.896101.983575@napali.hpl.hp.com>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<15844.31669.896101.983575@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Wed, 27 Nov 2002 00:00:53 -0800
   
   It should be safe to declare the syscall
   return type always as "long", no?
   
Sign extension is a rule of the architecture.

So if the platform says "int shall not be sign
extended to 64-bits", declaring as long is wrong.
