Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288565AbSBDGHj>; Mon, 4 Feb 2002 01:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSBDGH2>; Mon, 4 Feb 2002 01:07:28 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:16003 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S288565AbSBDGHP>;
	Mon, 4 Feb 2002 01:07:15 -0500
Date: Mon, 4 Feb 2002 01:07:15 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre7 Compile bug?
Message-ID: <Pine.LNX.4.30.0202040104330.1272-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In net/ipv4/netfilter/ipfwadm_core.c on lines like 691, 735, and a few
others there's an incorrect call to MOD_INC_USE_COUNT and
MOD_DEC_USE_COUNT.  That macro is being called incorrectly and causes the
compiler to get confused.  I think what the author meant to do was
'MOD_DEC_USE_COUNT' (which implies THIS_MODULE) but (s)he really did
MOD_DEC_USE_COUNT().

At any rate, shall I submit a patch to fix this typo or has someone
already patched this?

-Calin

