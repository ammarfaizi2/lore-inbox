Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUDOWcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUDOWcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:32:41 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:17809
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S261252AbUDOWck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:32:40 -0400
Subject: Re: NFS proc entry
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Fabian Frederick <Fabian.Frederick@skynet.be>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <407F06BD.3010905@nortelnetworks.com>
References: <1082060754.9112.2.camel@bluerhyme.real3>
	 <1082065633.7141.52.camel@lade.trondhjem.org>
	 <407F06BD.3010905@nortelnetworks.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1082068356.7141.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 15:32:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 15/04/2004 klokka 15:03, skreiv Chris Friesen:
> However, with the current setup filesystem monitoring deamons must fork 
> off a child for each mount, since statfs() can block for many seconds if 
> the server has gone away.

So exactly how would moving that monitoring into the kernel change the
parameters of the above problem? The kernel has exactly the same issues:
The only way it can tell if the server is down is by probing the
connection and timing out. That's the reason why those userland child
processes end up hanging in the first place.

Cheers,
  Trond
