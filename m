Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTKQUQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTKQUQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:16:30 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:50377 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263698AbTKQUQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:16:29 -0500
Date: Mon, 17 Nov 2003 15:04:51 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CONFIG_CRC32 in 2.4.22 breaks PCMCIA
Message-ID: <20031117200451.GA12931@pimlott.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CRC32 was introduced in 2.4.22.  I found that if I didn't
explicitly set it, the pcnet_cs driver from stand-alone PCMCIA
distribution didn't work.  PCMCIA relies on the crc functions, and
since they were always available before 2.4.22, it doesn't check for
them.

This seems to be significant breakage, and it took me a good while
to figure out what was going on.  Is this change reasonable in the
stable kernel series?

Andrew
