Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVKRTj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVKRTj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVKRTj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:39:59 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:31408 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932224AbVKRTj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:39:59 -0500
Date: Fri, 18 Nov 2005 14:39:57 -0500
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Does Linux has File Stream mapping support...?
Message-ID: <20051118193957.GI9488@csclub.uwaterloo.ca>
References: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 06:21:59PM +0530, Arijit Das wrote:
> Ye...I know of tee.
> 
> But the issue here is I have a HUGE Compiler (an Simulation tool) in which thousands of places there are "printf" statements to print messages to STDOUT stream. Now, a requirement came up which needs all those messages thrown to STDOUT also to be logged in a LOGFILE (in addition to STDOUT). Yes, this can be done through tee...but the usage model of the compiler doesn't leave that possibility open for me. 
> 
> So, am looking for a solution inside the Compiler code.

Replace all printf's with a MACRO that expands to two different printf's
one to stdout and one to a log.  Not pretty though I suppose.

Or you make your own function to replace all printf's with that does the
output and any logging you want done.

Len Sorensen
