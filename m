Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270474AbTG1SvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270486AbTG1SvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:51:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64898 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270474AbTG1SvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:51:08 -0400
Date: Mon, 28 Jul 2003 20:05:43 +0100
From: Jamie Lokier <jamie@shareable.org>
To: James Stevenson <james@stev.org>
Cc: Doruk Fisek <dfisek@fisek.com.tr>, linux-kernel@vger.kernel.org
Subject: Re: hw tcp v4 csum failed
Message-ID: <20030728190543.GA10426@mail.jlokier.co.uk>
References: <20030727100246.4bfb860c.dfisek@fisek.com.tr> <Pine.LNX.4.44.0307280135420.4847-100000@jlap.stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307280135420.4847-100000@jlap.stev.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson wrote:
> >  I am getting "hw tcp v4 csum failed" errors using a BCM5701 ethernet
> > adapter with the tigon3 driver in a vanilla 2.4.20 kernel.

> Its probably a problem releated to the cable or surrounding
> interference on the cable.

This is an ethernet adapter.  It means that interference problems
should cause CRC32 errors, and the packets will be dropped/logged at
the MAC layer, and the TCP checksum not checked.  The MAC layer CRC32
is strong enough that TCP checksum errors should be exceedingly rare,
unless the interference is very bad and a very large number of packes
are being submitted.

Perhaps the error message is not really indicating TCP checksum errors?

-- Jamie
