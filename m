Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272483AbTHEHVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272484AbTHEHVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:21:09 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:57500
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272483AbTHEHVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:21:08 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 17:26:14 +1000
User-Agent: KMail/1.5.3
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
References: <200308050207.18096.kernel@kolivas.org> <1060059844.3f2f3ac46e2f2@kolivas.org> <20030804230337.703de772.akpm@osdl.org>
In-Reply-To: <20030804230337.703de772.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051726.14501.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 16:03, Andrew Morton wrote:
> We do prefer that TASK_UNINTERRUPTIBLE processes are woken promptly so they
> can submit more IO and go back to sleep.  Remember that we are artificially
> leaving the disk head idle in the expectation that the task will submit
> more I/O.  It's pretty sad if the CPU scheduler leaves the anticipated task
> in the doldrums for five milliseconds.

Indeed that has been on my mind. This change doesn't affect how long it takes 
to wake up. It simply prevents tasks from getting full interactive status 
during the period they are doing unint. sleep.

> Very early on in AS development I was playing with adding "extra boost" to
> the anticipated-upon task, but it did appear that the stock scheduler was
> sufficiently doing the right thing anyway.

Con

