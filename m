Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265540AbRFVWIH>; Fri, 22 Jun 2001 18:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbRFVWH5>; Fri, 22 Jun 2001 18:07:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18958 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265540AbRFVWHp>; Fri, 22 Jun 2001 18:07:45 -0400
Subject: Re: /dev/nvram driver
To: thockin@sun.com (Tim Hockin)
Date: Fri, 22 Jun 2001 23:07:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B339380.C0D973CB@sun.com> from "Tim Hockin" at Jun 22, 2001 11:50:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DZ54-0004FC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently it tracks O_EXCL on open() and sets a flag, whereby no other
> open() calls can succeed.  Is this functionality really needed?  Perhaps it
> should just be a reader/writer model : n readers or 1 writer.  In that
> case, should open() block on a writer, or return -EBUSY?

Several tools expect that mode of behaviour so that they can atomically
recompute the checksum when writing low bytes of the CMOS
