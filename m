Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVJUN2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVJUN2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVJUN2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:28:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30170 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964942AbVJUN2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:28:18 -0400
Date: Fri, 21 Oct 2005 15:28:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] swsusp: clean up resume error path
Message-ID: <20051021132817.GB5768@atrey.karlin.mff.cuni.cz>
References: <200510172336.53194.rjw@sisk.pl> <200510172350.05415.rjw@sisk.pl> <20051017234723.GB13148@atrey.karlin.mff.cuni.cz> <200510181117.27068.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510181117.27068.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't like this one. restore_highmem() does freeing of allocated
> > pages. If swsusp_arch_suspend() fails in specific way, I suspect it
> > could leak highmem.
> 
> The pages to be freed are only allocated in suspend_prepare_image()
> (now swsusp_save()), which is on suspend, and this is the resume
> error path.

Ok, yes, you seem to be right. I was probably confused by my own
code. ACK on the patch (if it helps you).

								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
