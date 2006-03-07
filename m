Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWCGBYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWCGBYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWCGBYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:24:44 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37550 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932589AbWCGBYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:24:43 -0500
Date: Tue, 7 Mar 2006 01:24:38 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
Message-ID: <20060307012438.GL27946@ftp.linux.org.uk>
References: <20060306235248.20842700@localhost.localdomain> <20060306235249.880CB28A@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306235249.880CB28A@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 03:52:49PM -0800, Dave Hansen wrote:
> 
> Right now, sysctls can only deal with global variables.  This
> patch makes them a _little_ more flexible by allowing there to
> be an accessor function to get at the variable being changed,
> instead of it being global.
> 
> This allows the sysctls to be backed by variables that are,
> for instance, dynamically allocated and not available at
> compile-time.
> 
> This also provides a very simple mechanism to take things that
> are currently global and containerize them.
> 

This is disgusting.  Please, don't pile more and more complexity into
sysctl_table - it's already choke-full of it and needs to be simplified,
not to grow more crap.

NAK.
