Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWGMJA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWGMJA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWGMJA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:00:27 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:47114 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S964853AbWGMJA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:00:26 -0400
Date: Thu, 13 Jul 2006 10:58:08 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: sparse warnings for variable length arrays
Message-ID: <20060713085808.GA9566@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

in include/asm-s390/bitops.h we have several typedefs:

typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;

sparse warns about these with "error: bad constant expression".
Is there any way to tell sparse to be quiet? __force doesn't seem to work.
