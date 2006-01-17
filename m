Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWAQRIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWAQRIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWAQRIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:08:55 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:11424 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932188AbWAQRIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:08:54 -0500
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
From: Dave Hansen <haveblue@us.ibm.com>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <43CD18FF.4070006@FreeBSD.org>
References: <20060117143258.150807000@sergelap>
	 <43CD18FF.4070006@FreeBSD.org>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 09:08:18 -0800
Message-Id: <1137517698.8091.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 08:19 -0800, Suleiman Souhlal wrote:
> Serge Hallyn wrote:
> > The mechanism to start a container 
> > is to 'echo "container_name" > /proc/container'  which creates a new
> > container and associates the calling process with it. All subsequently
> > forked tasks then belong to that container.
> > There is a separate pid space associated with each container.
> > Only processes/task belonging to the same container "see" each other.
> 
> Why does there need a separate pid space for each container?
> You don't really need one to make sure that only processes in the same 
> containers can see each other.

One use for containers might be to pick a container from a system, wrap
it up, and transport it to another system where it would continue to
run.  We would have to make sure that the pids did not collide with any
containers running on the target system.

-- Dave

