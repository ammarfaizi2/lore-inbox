Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbTARD0F>; Fri, 17 Jan 2003 22:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTARD0F>; Fri, 17 Jan 2003 22:26:05 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:29132 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262296AbTARD0F>;
	Fri, 17 Jan 2003 22:26:05 -0500
Date: Sat, 18 Jan 2003 03:34:35 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ralf Baechle <ralf@gnu.org>, linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>;
Subject: Minor header bug? MIPS (32-bit) nlink_t sign
Message-ID: <20030118033435.GC18282@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux/MIPS32 is unusual in that its type of nlink_t is signed.  In the
header <asm-mips64/posix_types.h>, the 32-bit compatibility type for
nlink_t is defined as unsigned.  Perhaps this is because the MIPS
64-bit nlink_t is always unsigned.

Which header is correct - and which should be changed for consistency -
<asm-mips/posix_types.h> or <asm-mips64/posix_types.h>?

Stephen, I guess you have already figured this out with your recent
32-bit compatibility cleanup?

cheers,
-- Jamie
