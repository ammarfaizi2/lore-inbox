Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTFBM7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTFBM7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:59:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13962 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262290AbTFBM7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:59:16 -0400
Date: Mon, 2 Jun 2003 06:13:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com,
       pmckenne@us.ibm.com
Subject: Re: Always passing mm and vma down (was: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race)
Message-ID: <20030602131305.GA1370@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030530164150.A26766@us.ibm.com> <20030531104617.J672@nightmaster.csn.tu-chemnitz.de> <20030531234816.GB1408@us.ibm.com> <20030601122200.GB1455@x30.local> <20030601200056.GA1471@us.ibm.com> <1054542770.5187.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054542770.5187.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 10:32:50AM +0200, Arjan van de Ven wrote:
> On Sun, 2003-06-01 at 22:00, Paul E. McKenney wrote:
> > The immediate motivation is to avoid the race with zap_page_range()
> > when another node writes to the corresponding portion of the file,
> > similar to the situation with vmtruncate().  The thought was to
> > leverage locking within the distributed filesystem, but if the
> > race is solved locally, then, as you say, perhaps this is not 
> > necessary.
> 
> is said distributed filesystem open source by chance ?

At least one soon will be.

					Thanx, Paul
