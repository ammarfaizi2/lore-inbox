Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUB2GkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 01:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUB2GiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 01:38:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:3774 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261987AbUB2Ggd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 01:36:33 -0500
Subject: Re: [PATCH] ppc64: Add iommu=on for enabling DART on small-mem
	machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Olof Johansson <olof@austin.ibm.com>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
In-Reply-To: <40417E66.3060707@matchmail.com>
References: <Pine.A41.4.44.0402280818060.43148-100000@forte.austin.ibm.com>
	 <40417E66.3060707@matchmail.com>
Content-Type: text/plain
Message-Id: <1078036010.10826.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 29 Feb 2004 17:26:50 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And maybe even some generic code? :-D

No. It's not possible, at least not at this point. The decision of
allocating the DART space or not (and thus eventually stripping the
max available memory) is done very early. So early that the kernel
isn't yet running at it's link location ;) So the kind of code we
can actually run at this point is limited, with various tweaks to
deal with the relocation issue.

It's not very pretty, I hope we can improve that later, but that
is not something that will happen in the upcoming weeks .

Ben.


