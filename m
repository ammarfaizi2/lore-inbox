Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVJSLQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVJSLQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJSLQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:16:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27348 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964801AbVJSLQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:16:05 -0400
Subject: Re: Sequence of network cards
From: Arjan van de Ven <arjan@infradead.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051019104712.GC9765@kestrel>
References: <20051019104712.GC9765@kestrel>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 13:15:55 +0200
Message-Id: <1129720556.2822.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is the algorithm for assignment of eth? numbers by Linux kernel
> documented anywhere?

it's generally on a pci bus order. However... if you switch to acpi by
going from 2.4 to 2.6, the pci bus order might change.

The good news is that you can do a few things to mitigate this:
1) Several distros (including Fedora Core) allow you to bind ethX
numbers to mac addresses, eg effectively persistent binding of ethX
numbers to specific cards
2) you can rename ethX to ethY yourself with nameif and similar tools.


