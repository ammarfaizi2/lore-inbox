Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTJQWXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTJQWXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:23:24 -0400
Received: from waste.org ([209.173.204.2]:63438 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263628AbTJQWXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:23:23 -0400
Date: Fri, 17 Oct 2003 17:23:13 -0500
From: Matt Mackall <mpm@selenic.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-ID: <20031017222313.GF5725@waste.org>
References: <200310171610.36569.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310171610.36569.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 04:10:36PM -0600, Bjorn Helgaas wrote:
> I expect there are probably different opinions about the idea
> that "dd if=/dev/mem" exits without doing anything.  Sparc and
> 68K have nearby code that bit-buckets writes and returns zeroes
> for reads of page zero.  We could do that, too, but it seems like
> kind of a hack, and holes on ia64 can be BIG (on the order of
> 256GB for one box).

I don't see any reason not to returns zeros. A hole in a file does the
same thing, after all. The fact that the hole is big makes no difference.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
