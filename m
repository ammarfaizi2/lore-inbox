Return-Path: <linux-kernel-owner+w=401wt.eu-S1423052AbWLUTbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423052AbWLUTbI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423054AbWLUTbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:31:08 -0500
Received: from smtp-out.google.com ([216.239.33.17]:1425 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423053AbWLUTbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:31:06 -0500
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 14:31:06 EST
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:x-mailer:
	mime-version:content-type:content-transfer-encoding;
	b=mCPkbxLhyjuWxXqbS7/j/PbK3mCUX8KEZ1ZhH+DgPGP4gdxl+l3QyFPgaXIEFVeHG
	CSQMD36/r0Kj+QlxNYzUw==
Date: Thu, 21 Dec 2006 11:15:11 -0800
From: Andrew Morton <akpm@google.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: performance regression due to recent block changes
Message-Id: <20061221111511.c3897be6.akpm@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, the elapsed time for `mkefs2 /dev/hdc5' has just gone from nine
seconds to sixty, with the anticipatory scheduler (at least).  It is due to
your recent merge.

This is the enty enth time that block changes have been slammed into
mainline without having had any exposure to -mm testers or even to me
personally.  And it's the second time obvious regressions have gone in as a
result.  I have a New Year's resolution for you ;)
