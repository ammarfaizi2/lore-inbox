Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSHDAl5>; Sat, 3 Aug 2002 20:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSHDAl4>; Sat, 3 Aug 2002 20:41:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23475 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318038AbSHDAlz>;
	Sat, 3 Aug 2002 20:41:55 -0400
Date: Sat, 03 Aug 2002 17:31:11 -0700 (PDT)
Message-Id: <20020803.173111.78037842.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: frankeh@watson.ibm.com, torvalds@transmeta.com, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15692.12781.344389.519591@napali.hpl.hp.com>
References: <15691.24200.512998.875390@napali.hpl.hp.com>
	<200208031441.29353.frankeh@watson.ibm.com>
	<15692.12781.344389.519591@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Sat, 3 Aug 2002 12:41:33 -0700

   It appears that Juan Navarro, the primary author behind the Rice
   project, is working on breaking down the superpage benefits they
   observed.  That would tell us how much benefit is due to page-coloring
   and how much is due to TLB effects.  Here in our lab, we do have some
   (weak) empirical evidence that some of the SPECint benchmarks benefit
   primarily from page-coloring, but clearly there are others that are
   TLB limited.

There was some comparison done between large-page vs. plain
page coloring for a bunch of scientific number crunchers.

Only one benefitted from page coloring and not from TLB
superpage use.

The ones that benefitted from both coloring and superpages, the
superpage gain was about equal to the coloring gain.  Basically,
superpages ended up giving the necessary coloring :-)

Search for the topic "Areas for superpage discussion" in the
sparclinux@vger.kernel.org list archives, it has pointers to
all the patches and test programs involved.
