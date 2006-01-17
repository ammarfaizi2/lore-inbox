Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWAQSMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWAQSMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWAQSMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:12:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62445 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932096AbWAQSMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:12:50 -0500
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
From: Dave Hansen <haveblue@us.ibm.com>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <43CD32F0.9010506@FreeBSD.org>
References: <20060117143258.150807000@sergelap>
	 <43CD18FF.4070006@FreeBSD.org>
	 <1137517698.8091.29.camel@localhost.localdomain>
	 <43CD32F0.9010506@FreeBSD.org>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 10:12:37 -0800
Message-Id: <1137521557.5526.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 10:09 -0800, Suleiman Souhlal wrote:
> Dave Hansen wrote:
> > One use for containers might be to pick a container from a system, wrap
> > it up, and transport it to another system where it would continue to
> > run.  We would have to make sure that the pids did not collide with any
> > containers running on the target system.
> 
> Couldn't you assign new pids when the container is transported to the 
> other system?

You do assign new pids, at least as far as the kernel is concerned.
However, any processes that continue to run would get confused if their
pid changed.  You have to make sure that the tasks have a _consistent_
view of which process is which pid.

-- Dave

