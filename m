Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935664AbWK3K7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935664AbWK3K7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935683AbWK3K7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:59:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20134 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S935664AbWK3K7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:59:31 -0500
Date: Thu, 30 Nov 2006 11:06:11 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
 hyper-threading.
Message-ID: <20061130110611.03aff95c@localhost.localdomain>
In-Reply-To: <11648607733630-git-send-email-bcollins@ubuntu.com>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	<11648607733630-git-send-email-bcollins@ubuntu.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 23:26:05 -0500
Ben Collins <bcollins@ubuntu.com> wrote:

> This patch adds a config option to allow disabling hyper-threading by
> default, and a kernel command line option to changes this default at
> boot time.
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>

The description is wrong - this does not disable hyperthreading it merely
leaves one thread idle. I don't believe Intel have ever published a
procedure for truely disabling HT, but if you idle a thread you may want
to adjust the cache settings on a PIV (10.5.6 in the intel docs) and set
it to shared mode. Need to play more with what the bios does I guess.

So Ack but with the proviso it should say "Ignoring" or "Not using" not
"Disabling", because it does not do the latter and there seem to be
performance differences as a result

Acked-by: Alan Cox <alan@redhat.com>

Alan
