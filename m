Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVAUVlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVAUVlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVAUVjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:39:04 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:44296 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262517AbVAUVht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:37:49 -0500
To: Brandon Corey <bcorey@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pollable Semaphores
X-Message-Flag: Warning: May contain useful information
References: <20050121212212.GA453910@firefly.engr.sgi.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 21 Jan 2005 13:37:47 -0800
In-Reply-To: <20050121212212.GA453910@firefly.engr.sgi.com> (Brandon Corey's
 message of "Fri, 21 Jan 2005 13:22:12 -0800")
Message-ID: <521xceqx90.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Jan 2005 21:37:48.0456 (UTC) FILETIME=[739CF280:01C50001]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Brandon> I'm trying to find out if there is a pollable semaphore
    Brandon> equivalent on Linux.  The main idea of a "pollable
    Brandon> semaphore", is a semaphore with a related file
    Brandon> descriptor.  The file descriptor can be used to select()
    Brandon> when the semaphore is acquirable.  This provides a
    Brandon> convenient way for users to implement code
    Brandon> synchronization between threads, where multiple file
    Brandon> descriptors are already being selected against.

Yes, I believe futexes and specifically FUTEX_FD can be used to
implement this.  See http://people.redhat.com/~drepper/futex.pdf for
full details.

 - Roland
