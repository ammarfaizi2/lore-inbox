Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbSJVADG>; Mon, 21 Oct 2002 20:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSJVADG>; Mon, 21 Oct 2002 20:03:06 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:25285 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261834AbSJVADG>;
	Mon, 21 Oct 2002 20:03:06 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15796.38594.516266.130894@napali.hpl.hp.com>
Date: Mon, 21 Oct 2002 17:07:30 -0700
To: Erich Focht <efocht@ess.nec.de>
Cc: David Mosberger <davidm@hpl.hp.com>, Matthew Dobson <colpatch@us.ibm.com>,
       "linux-ia64" <linux-ia64@linuxia64.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] topology for ia64
In-Reply-To: <200210051904.22480.efocht@ess.nec.de>
References: <200210051904.22480.efocht@ess.nec.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 5 Oct 2002 19:04:22 +0200, Erich Focht <efocht@ess.nec.de> said:

  Erich> Hi David, please find attached a first attempt to implement
  Erich> the topology.h macros/routines for IA64. We need this for the
  Erich> NUMA scheduler setup.

Why does the cpu_to_node_map[] exist for non-NUMA configurations?  It
seems to me that it would be better to make cpu_to_node_map a macro
that uses an array-check for NUMA configurations and a simple test
against phys_cpu_present_map() for non-NUMA.

	--david
