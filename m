Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbTINJDu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 05:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTINJDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 05:03:50 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62732 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262339AbTINJDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 05:03:49 -0400
Date: Sun, 14 Sep 2003 11:12:12 +0200
To: Robert Love <rml@tech9.net>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
Message-ID: <20030914091212.GA18339@hh.idb.hist.no>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> <20030913174825.GB7404@mail.jlokier.co.uk> <1063476152.24473.30.camel@localhost> <20030913220401.GA17528@hh.idb.hist.no> <1063500950.24473.34.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063500950.24473.34.camel@localhost>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 08:55:50PM -0400, Robert Love wrote:
> On Sat, 2003-09-13 at 18:04, Helge Hafting wrote:
> 
> > So a "complicated" oom handler need to preallocate all the memory
> > it might ever need.  Not impossible.
> 
> Right.  I was just pointing it out.
> 
> Preallocating isn't necessarily possible e.g. you need something
> dynamically, need to call back into user-space, etc.
>
The userspace side is solvable by starting a userspace
oom handler that mlocks all the memory it
might ever need before it gets scarce.  It won't
need to run other programs - it can do anything
other programs do itself.

Helge Hafting 
