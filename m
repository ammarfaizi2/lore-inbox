Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTBUD02>; Thu, 20 Feb 2003 22:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbTBUD02>; Thu, 20 Feb 2003 22:26:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18893 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267102AbTBUD01>;
	Thu, 20 Feb 2003 22:26:27 -0500
Date: Thu, 20 Feb 2003 19:20:33 -0800 (PST)
Message-Id: <20030220.192033.94852330.davem@redhat.com>
To: maxk@qualcomm.com
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: ioctl32 consolidation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20030220172624.0d4c5070@mail1.qualcomm.com>
References: <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
	<20030220.163619.133744671.davem@redhat.com>
	<5.1.0.14.2.20030220172624.0d4c5070@mail1.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Max Krasnyansky <maxk@qualcomm.com>
   Date: Thu, 20 Feb 2003 17:31:43 -0800

   Am I missing something here ?

The data type for things passed into SIOCDEVPRIVATE is
totally opaque.

Multiple drivers, passing in different kinds of data,
use SIOCDEVPRIVATE.  It is inherenly untranslatable
at the point where we are at sys_ioctl32().
