Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSIZAa2>; Wed, 25 Sep 2002 20:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbSIZAa2>; Wed, 25 Sep 2002 20:30:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16001 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261415AbSIZAa1>;
	Wed, 25 Sep 2002 20:30:27 -0400
Date: Wed, 25 Sep 2002 17:29:31 -0700 (PDT)
Message-Id: <20020925.172931.115908839.davem@redhat.com>
To: ak@suse.de
Cc: niv@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73n0q5sib2.fsf@oldwotan.suse.de>
References: <3D924F9D.C2DCF56A@us.ibm.com.suse.lists.linux.kernel>
	<20020925.170336.77023245.davem@redhat.com.suse.lists.linux.kernel>
	<p73n0q5sib2.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 26 Sep 2002 02:31:13 +0200

   "David S. Miller" <davem@redhat.com> writes:
   >    
   > In fact the exact opposite, such a suggested flow cache is about
   > as parallel as you can make it.
   
   It sounds more like it would include the FIB too.

That's the second level cache, not the top level lookup which
is what hits %99 of the time.
   
   The current FIBs have a bit heavier locking at least. Fine grain locking
   btrees is also not easy/nice.
   
Also not necessary, only the top level cache really needs to be
top performance.
