Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTJAMTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 08:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTJAMTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 08:19:03 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:4490 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262115AbTJAMTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 08:19:01 -0400
Date: Wed, 1 Oct 2003 14:18:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: include/linux/nfs/nfsfh.h declares a symbol
Message-ID: <20031001121811.GE31698@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil, the function SVCFH_fmt uses a static variable to sprintf into.
Looks like this variable is declared locally for every .c file
including nfsfh.h, which is quite a few.

You could remove the static, but that would increase the stack usage,
which might be a problem too.  The buffer could be reduced to 64
chars, to reduce that problem.  kmalloc()ing it seems a bit expensive,
but might be an option, too.

Thanks!

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
