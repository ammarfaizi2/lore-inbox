Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTEMQxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTEMQxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:53:21 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:25779 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S262299AbTEMQxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:53:20 -0400
Date: Tue, 13 May 2003 19:05:36 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.86+: sizes of almost all files in sysfs are 4k?
Message-ID: <20030513170536.GA4580@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <20030423082727.GE890@riesen-pc.gr05.synopsys.com> <Pine.LNX.4.44.0305130954390.9816-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305130954390.9816-100000@cherise>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel, Tue, May 13, 2003 18:58:34 +0200:
> > If the size is not simple/possible to calculate, maybe using 0
> > would be an option for the cases where the size doesn't carry
> > any information (like in procfs)?
> 
> It was 0 before, which works fine for cat(1). By hardcoding the size, some 
> bugs are exposed, since the size is reset for some reason when you try to 
> open the file for writing, even if open(2) returns an error. 
> 
> Ideally, we should be calculating the size, and using that. However, that 
> would involve keeping type information about the file around, which we 
> don't currently do. Research/patches in this area would be greatly 
> appreciated. 

we could also pretend the files are sparse, and return zero-filled data.
Though, i fear, this will also confuse something.

-alex
