Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSKHUxo>; Fri, 8 Nov 2002 15:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSKHUxo>; Fri, 8 Nov 2002 15:53:44 -0500
Received: from fmr05.intel.com ([134.134.136.6]:18900 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262384AbSKHUxn>; Fri, 8 Nov 2002 15:53:43 -0500
Date: Fri, 8 Nov 2002 13:00:26 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
Message-Id: <200211082100.gA8L0Q515460@linux.intel.com>
To: vamsi@in.ibm.com
Subject: Multiple kprobes per address
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that kprobes is designed around the idea of only allowing
a single probe point per probe address.  Why not allow multiple probe
points for a given probe address?  Is it a way of limiting complexity?

It looks like it would be fairly straight forward to change get_kprobe(addr)
to be get_kprobes(addr) where it returns a list of probe points associated
with the address, and then tweak do_int3 to work through the entire list.
Would such a change be acceptable?

     -rustyl
