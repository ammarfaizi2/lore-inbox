Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTFYM27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTFYM27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:28:59 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:3540 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S264015AbTFYM27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:28:59 -0400
Subject: Re: [PATCH] Fix mtdblock / mtdpart / mtdconcat
From: David Woodhouse <dwmw2@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
In-Reply-To: <20030623010031.E16537@flint.arm.linux.org.uk>
References: <20030623010031.E16537@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Red Hat UK Ltd.
Message-Id: <1056544988.24294.9.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Wed, 25 Jun 2003 13:43:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 01:00, Russell King wrote:
> Dirtily disable ECC support; it doesn't work when mtdpart is layered
> on top of mtdconcat on top of CFI flash.
> 
> There is probably a better fix, but that's for someone else to find.

I had to run 'indent' on mtdconcat.c before I could stand to even look
for it, so I haven't attached the patch here -- but could you try v1.6
from CVS, which should refrain from pretending to have ecc/oob access
functions of none of the subdevices have them, and hence fix the problem
you observed.

-- 
dwmw2
