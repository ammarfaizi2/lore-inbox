Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWDVRRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWDVRRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWDVRRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:17:12 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12693 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750745AbWDVRRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:17:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17481.60890.127240.334557@cargo.ozlabs.ibm.com>
Date: Sat, 22 Apr 2006 18:48:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Andrew Morton" <akpm@osdl.org>, "James Morris" <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
In-Reply-To: <84144f020604220043i65502955ha6dc2759d8cd665b@mail.gmail.com>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	<Pine.LNX.4.64.0604210322110.21429@d.namei>
	<20060421015412.49a554fa.akpm@osdl.org>
	<17481.28892.506618.865014@cargo.ozlabs.ibm.com>
	<84144f020604220043i65502955ha6dc2759d8cd665b@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg writes:

> No, it's not the janitors fault that we have paths doing lots of
> kfree(NULL) calls. NULL check removal didn't create the problem, but
> it makes it more visible definitely.

There is a judgement to be made at each call site of kfree (and
similar functions) about whether the argument is rarely NULL, or could
often be NULL.  If the janitors have been making this judgement, I
apologise, but I haven't seen them doing that.

Paul.
