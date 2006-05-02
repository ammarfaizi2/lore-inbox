Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWEBP2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWEBP2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWEBP2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:28:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17305 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964883AbWEBP2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:28:42 -0400
Date: Tue, 2 May 2006 16:28:37 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <20060502152837.GY27946@ftp.linux.org.uk>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il> <20060502143430.GW27946@ftp.linux.org.uk> <445774F7.5030106@argo.co.il> <20060502151525.GX27946@ftp.linux.org.uk> <44577887.7040506@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44577887.7040506@argo.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 06:19:35PM +0300, Avi Kivity wrote:
> Al Viro wrote:
> >On Tue, May 02, 2006 at 06:04:23PM +0300, Avi Kivity wrote:
> >  
> >>BTW, C++ could take over some of sparse's function:
> >>    
> >
> >And the point of that would be?  sparse is _fast_ and easy to modify;
> >g++ is neither.
> >  
> 
> I wasn't talking about modifying gcc to do the checking, rather using 
> language features so that the checks would happen during a regular 
> compile. That would mean we weren't dependent on somebody running sparse 
> with a configuration that triggers the bug, but those few who compile 
> the code before submitting the patch would get it automatically checked.

g++ won't cover all checks sparse is capable of, so you still want to
run the latter over new code anyway (== pass C=1 to make).  IOW, type
safety from C++ isn't particulary good argument.
