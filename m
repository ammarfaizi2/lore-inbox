Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWGCUwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWGCUwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWGCUwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:52:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11475 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932104AbWGCUv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:51:59 -0400
Subject: Re: [Ubuntu PATCH] Add Dothan frequency tables for speedstep
From: Arjan van de Ven <arjan@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       davej@codemonkey.org.uk
In-Reply-To: <44A98250.6060508@oracle.com>
References: <44A98250.6060508@oracle.com>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 22:51:56 +0200
Message-Id: <1151959916.3108.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 13:47 -0700, Randy Dunlap wrote:
> Patch to Add Dothan frequency tables for speedstep.
> 
> Does this conflict with other Dothan handling?
> 
> patch location:

as discussed on the power management summit: this is the wrong approach.

The BIOS gives you these tables. The reference bios has all of them, but
if a testing failure (for example due to voltage regulator limits or
cooling limits) a specific machine can't do a certain state, the bios of
that machine drops that state. It's a BAD IDEA to then add that state
back via the back door!

It's not as if the bios people remove random states... that's work. They
only change such things if they really really have to...



