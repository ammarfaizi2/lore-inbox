Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUIWIGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUIWIGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 04:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUIWIGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 04:06:31 -0400
Received: from colin2.muc.de ([193.149.48.15]:57362 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268321AbUIWIG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 04:06:29 -0400
Date: 23 Sep 2004 10:06:28 +0200
Date: Thu, 23 Sep 2004 10:06:28 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com,
       Tom Rini <trini@kernel.crashing.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Patch] kprobes exception notifier fix 2.6.9-rc2
Message-ID: <20040923080627.GA89752@muc.de>
References: <20040923053029.GB1291@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923053029.GB1291@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 11:00:29AM +0530, Prasanna S Panchamukhi wrote:
> In order to make other debuggers use exception notifiers, kprobes 
> notifier return values are required to be modified. This patch modifies the
> return values of kprobes notifier return values in a clean way.

It's incompatible to x86-64. If you change anything in exception
notifiers change both.

And I don't really see the sense of inverting the test: NOTIFY_OK
for handling the exception should be as good as NOTIFY_STOP.

-Andi
