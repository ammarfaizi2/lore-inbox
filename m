Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWAPXMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWAPXMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWAPXMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:12:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:20143 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751261AbWAPXMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:12:43 -0500
Subject: Re: 2.6.15 on powerbook 15" still oopsing on resume with cd/dvd in
	drive
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1137398855.19444.2.camel@mindpipe>
References: <1137318398.24666.25.camel@localhost>
	 <1137398855.19444.2.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 10:12:29 +1100
Message-Id: <1137453150.4823.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 03:07 -0500, Lee Revell wrote:
> On Sun, 2006-01-15 at 10:46 +0100, Soeren Sonnenburg wrote:
> > BUG: soft lockup detected on CPU#0!
> 
> Not an oops but a soft lockup.  It means some piece of code ran in the
> kernel for a very long time.
> 
> This seems like a false positive to me, as it involves IDE.

Yup, it definitely looks like a false positive... unfortunately, the IDE
layer is a bit dumb and waits for the disk to wake up without
scheduling.

Ben.


