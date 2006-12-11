Return-Path: <linux-kernel-owner+w=401wt.eu-S1762775AbWLKKlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762775AbWLKKlp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762776AbWLKKlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:41:45 -0500
Received: from twin.jikos.cz ([213.151.79.26]:36767 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762775AbWLKKlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:41:45 -0500
Date: Mon, 11 Dec 2006 11:41:19 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612111137360.1665@twin.jikos.cz>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006, Andrew Morton wrote:

> Temporarily at
> 	http://userweb.kernel.org/~akpm/2.6.19-mm1/

Am I the only one seeing something strange on ext3 with this kernel?

For example /etc/resolv.conf gets corrupted during the dhclient run. It 
looks like this, after dhclient finishes:

0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
00003f0 0000 0000 0000 0000 2300 2020 2020 2020
0000400 0000 0000 0000 0000 0000 0000 0000 0000
*
0000510 0000 0000 0000 0000 0000 0000 0000 6e00
0000520 6d61 7365 7265 6576 2072 3031 322e 2e30
0000530 2e30 0a38
0000534

ctags -R also produces invalid tags file (also lots of padding with zero 
bytes).

Will try to track down what causes it.

-- 
Jiri Kosina
