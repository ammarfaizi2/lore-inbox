Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWFAMTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWFAMTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 08:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWFAMTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 08:19:44 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:45200 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750880AbWFAMTo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 08:19:44 -0400
To: =?iso-8859-1?q?Oliver_K=F6nig?= <k.oliver@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed
References: <200605311409.40560.k.oliver@t-online.de>
From: Jes Sorensen <jes@sgi.com>
Date: 01 Jun 2006 08:19:32 -0400
In-Reply-To: <200605311409.40560.k.oliver@t-online.de>
Message-ID: <yq0d5dtt6ej.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=latin-iso8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Oliver" == Oliver König <k.oliver@t-online.de> writes:

Oliver> I run Debian 3.1 (Sarge) with Debian-Kernel 2.4.27-3-686-smp
Oliver> on Dell Poweredge 2850 with the following setup/config:

Oliver> Model: Dell Poweredge 2850 CPU: 2x3.0 GHz RAM: 2 GB SWAP: 1 GB
Oliver> Raid 1 with Dell PowerEdge Expandable RAID controller 4 (SCSI)
Oliver> Kernel: 2.4.27-3-686-smp (CONFIG_HIGHMEM4G=y) Web server:
Oliver> apache2 SQL server: mysql4.1 MTA: exim4

[snip]

Oliver> The server is then so slow tom react that the only way to get
Oliver> rid of the problem is to reset the server.

Oliver> What can we do to fix the problem?

0-order allocations means it cannot get even a single page of free
memory. You also see in the log the the OOM is kicking in. In other
words, totally out of memory.

You have two options, add more swap or add more memory. At the same
time it might be a good idea to try and monitor it to find out which
tasks are chewing away that much memory.

Cheers,
Jes
