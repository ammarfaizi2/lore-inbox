Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbUKEBgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUKEBgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKEBdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:33:32 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5058 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262523AbUKEAwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:52:30 -0500
Date: Thu, 4 Nov 2004 18:52:24 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [6/6] LSM Stacking: temporary setprocattr hack
Message-ID: <20041105005224.GB3792@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <1099609971.2096.26.camel@serge.austin.ibm.com> <20041104144839.C2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104144839.C2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quoting Chris Wright (chrisw@osdl.org):
> * Serge Hallyn (serue@us.ibm.com) wrote:
> > Stacker assumes that data written to /proc/<pid>/attr/* is of the
> > form:
> > 
> > module_name: data
> 
> This breaks current tools where fields are space-delimited.  procps does
> filtering that way, and I believe libselinux does as well.

Oh, are you talking about the output of getprocattr?  Perhaps the output
should (temporarily) be default list the selinux info on the first line,
without a "selinux: " prepended, and list any other modules after?

Or do you mean something else?

You mentioned a common LSM sysfs framework.  Does it offer support for
both per-module and per-pid-per-module files?  If so, then I suppose it
would be fair to force LSMs to use those, and reserve the existing
{gs}etprocattr files for selinux use (or nuke them).

-serge
