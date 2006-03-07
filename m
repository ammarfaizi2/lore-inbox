Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWCGB5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWCGB5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWCGB5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:57:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47008 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751357AbWCGB5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:57:41 -0500
Date: Tue, 7 Mar 2006 01:57:41 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
Message-ID: <20060307015741.GM27946@ftp.linux.org.uk>
References: <20060306235248.20842700@localhost.localdomain> <20060306235249.880CB28A@localhost.localdomain> <20060307012438.GL27946@ftp.linux.org.uk> <1141696548.9274.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141696548.9274.48.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 05:55:48PM -0800, Dave Hansen wrote:
> On Tue, 2006-03-07 at 01:24 +0000, Al Viro wrote:
> > This is disgusting.  Please, don't pile more and more complexity into
> > sysctl_table - it's already choke-full of it and needs to be simplified,
> > not to grow more crap.
> 
> I don't completely disagree.  It certainly isn't the most elegant
> approach I've ever seen.
> 
> Any ideas on ways we could simplify it?  I was thinking that we could
> get rid of the .data member and allow access only via the mechanism I
> just introduced.  It would be pretty easy to make some macros to
> generate "simple" access functions for the existing global variables.

I'll resurrect the sysctl-cleanups tree and drop it on kernel.org tonight.
