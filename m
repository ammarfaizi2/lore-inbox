Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUCMBR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbUCMBR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:17:57 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:64144 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262925AbUCMBRz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:17:55 -0500
Subject: Re: calling flush_scheduled_work()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Tim Hockin <thockin@Sun.COM>, linux-kernel@vger.kernel.org
In-Reply-To: <20040312152747.0b3f74d3.akpm@osdl.org>
References: <20040312205814.GY1333@sun.com>
	 <20040312152747.0b3f74d3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1079140670.3166.87.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 20:17:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 12/03/2004 klokka 18:27, skreiv Andrew Morton:
> Seems simple enough to fix the workqueue code to handle this situation.
> 
> Wanna test this for me?

What if one of the workloads on the queue has another call to
flush_scheduled_work()? (which again finds itself calling another
instance, ...)
This fix doesn't really resolve the deadlock issue. It just reduces the
possibilities of it having any consequences...

Could you please at least include a dump_stack() before the call to
run_workqueue()) so that we can catch the bug in the act, and attempt to
fix it.

Cheers,
  Trond
