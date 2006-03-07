Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751989AbWCGB4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbWCGB4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbWCGB4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:56:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:61898 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751989AbWCGB4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:56:44 -0500
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
From: Dave Hansen <haveblue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
In-Reply-To: <20060307012438.GL27946@ftp.linux.org.uk>
References: <20060306235248.20842700@localhost.localdomain>
	 <20060306235249.880CB28A@localhost.localdomain>
	 <20060307012438.GL27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 17:55:48 -0800
Message-Id: <1141696548.9274.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 01:24 +0000, Al Viro wrote:
> This is disgusting.  Please, don't pile more and more complexity into
> sysctl_table - it's already choke-full of it and needs to be simplified,
> not to grow more crap.

I don't completely disagree.  It certainly isn't the most elegant
approach I've ever seen.

Any ideas on ways we could simplify it?  I was thinking that we could
get rid of the .data member and allow access only via the mechanism I
just introduced.  It would be pretty easy to make some macros to
generate "simple" access functions for the existing global variables.

-- Dave

