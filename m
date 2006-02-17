Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWBQO04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWBQO04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWBQO04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:26:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32163 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751440AbWBQO0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:26:55 -0500
Subject: Re: Fix IDE locking error.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
References: <20060216223916.GA8463@redhat.com>
	 <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Feb 2006 14:28:52 +0000
Message-Id: <1140186532.4283.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-02-17 at 09:57 +0100, Bartlomiej Zolnierkiewicz wrote:
> Could we get a decent description of the problem and of the patch?

Audit the lock state on all entries to the tune function and it
certainly was the case that the old IDE layer could call it with the
lock either already held or not.

Alan

