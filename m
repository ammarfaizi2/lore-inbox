Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUJXK1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUJXK1r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUJXK1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:27:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:8073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261426AbUJXK1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:27:46 -0400
Date: Sun, 24 Oct 2004 03:25:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] Fix incorrect kunmap_atomic in pktcdvd
Message-Id: <20041024032546.52314e23.akpm@osdl.org>
In-Reply-To: <m3wtxhibo9.fsf@telia.com>
References: <m3wtxhibo9.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
>  The pktcdvd driver uses kunmap_atomic() incorrectly. The function is
>  supposed to take an address as the first parameter, but the pktcdvd
>  driver passed a page pointer. Thanks to Douglas Gilbert and Jens Axboe
>  for discovering this.

You're about the 7,000th person to make that mistake.  We really should
catch it via typechecking but the code's really lame and nobody ever got
around to rotorooting it.
