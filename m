Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSK0Hxo>; Wed, 27 Nov 2002 02:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSK0Hxo>; Wed, 27 Nov 2002 02:53:44 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:60900 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261664AbSK0Hxk>;
	Wed, 27 Nov 2002 02:53:40 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15844.31669.896101.983575@napali.hpl.hp.com>
Date: Wed, 27 Nov 2002 00:00:53 -0800
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       anton@samba.org, "David S. Miller" <davem@redhat.com>, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
In-Reply-To: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 27 Nov 2002 18:42:28 +1100, Stephen Rothwell <sfr@canb.auug.org.au> said:

  Stephen> I make the follwing assumptions: returning s32 from a 32
  Stephen> bit compatibility system call is the same as returning long
  Stephen> or int.

That is not a safe assumption.  The ia64 ABI requires that a 32-bit
result is returned in the least-significant 32 bits only---the upper
32 bits may contain garbage.  It should be safe to declare the syscall
return type always as "long", no?

	--david
