Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSLWG2J>; Mon, 23 Dec 2002 01:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbSLWG2J>; Mon, 23 Dec 2002 01:28:09 -0500
Received: from franka.aracnet.com ([216.99.193.44]:37263 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266609AbSLWG2J>; Mon, 23 Dec 2002 01:28:09 -0500
Date: Sun, 22 Dec 2002 22:36:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 0/8 Move NUMA-Q support into subarch
Message-ID: <20930000.1040625374@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following sequnce of patches moves NUMA-Q into subarch, instead
of using clustered_apic_mode switching. It also selects the correct
pieces of clustered_apic_mode for Summit (some bits need to be off,
some on).

Most of the code was originally written by James Cleverdon - I have
split it, tidied it, and debugged it. The result is IMHO a sequence
of small easily readable chunks which should be easily seen to be
equivalent to current code, is much neater, and fixes things up for
Summit (IBM x440).

Tested on NUMA-Q, flat SMP, and UP (against 2.5.52). This time I 
remembered to check it compiled on UP with IO/APIC as well ;-)

Please consider for application to 2.5.

Martin.

