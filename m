Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269085AbTGORVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbTGORVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:21:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:2198 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S269085AbTGORVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:21:10 -0400
Date: Tue, 15 Jul 2003 18:35:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch] vesafb fix
Message-ID: <20030715173557.GB1491@mail.jlokier.co.uk>
References: <20030715141023.GA14133@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715141023.GA14133@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
>  * mtrr is enabled by default.  That should improve the vesafb
>    performance alot.  Also added a option to disable mtrr.

There used to be a vesafb problem with MTRRs when the framebuffer had
an odd size: 2.5MB of RAM (my laptop has this).

It would create an MTRR for the first 0.5MB of the framebuffer, and
then try to create another for the subsequent 2MB.

The latter failed because it's not suitably aligned - i.e. there was a
problem in th logic which splits non-power-of-two regions.

Is that fixed these days?

Cheers,
-- Jamie
