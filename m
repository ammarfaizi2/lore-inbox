Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbRFLQw2>; Tue, 12 Jun 2001 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbRFLQwH>; Tue, 12 Jun 2001 12:52:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6045 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261854AbRFLQwG>;
	Tue, 12 Jun 2001 12:52:06 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15142.18587.652613.378275@pizda.ninka.net>
Date: Tue, 12 Jun 2001 09:51:39 -0700 (PDT)
To: DJBARROW@de.ibm.com
Cc: Keith Owens <kaos@ocs.com.au>, schwidefsky@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c
In-Reply-To: <C1256A69.005BF601.00@d12mta09.de.ibm.com>
In-Reply-To: <C1256A69.005BF601.00@d12mta09.de.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DJBARROW@de.ibm.com writes:
 > This is a cure the syntom not the problem, build order shouldn't mess up
 > something this simple.

The refcounting issue you've described is a bug, and so is
initializing a network device before net_dev_init() has been invoked.
These two things are equally buggy.

Build order does mess up things this simple, look at the comments at
the top of drivers/scsi/Makefile if you don't believe me :-)

Later,
David S. Miller
davem@redhat.com
