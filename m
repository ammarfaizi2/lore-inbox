Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWJROvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWJROvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJROvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:51:43 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:23468 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161086AbWJROvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:51:42 -0400
Date: Wed, 18 Oct 2006 08:51:42 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Brian King <brking@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable pci device
Message-ID: <20061018145141.GO22289@parisc-linux.org>
References: <45354A59.3010109@us.ibm.com> <Pine.LNX.4.44L0.0610181035140.6766-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610181035140.6766-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 10:38:20AM -0400, Alan Stern wrote:
> You have to do _something_, because a user task could be about to read the
> configuration space at the exact moment you want to start the BIST.  That
> means ipr would have to wait until the user access is finished, which
> means it has to be prepared to sleep one way or another.

Actually, it only has to spin until the user has finished accessing
config space.  See the patch I just posted.
