Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTJQTDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTJQTDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:03:14 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:42880
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263491AbTJQTDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:03:13 -0400
Date: Fri, 17 Oct 2003 15:02:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Rik van Riel <riel@redhat.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, linux-mm@kvack.org
Subject: Re: 2.6.0-test7-mm1 4G/4G hanging at boot
In-Reply-To: <Pine.LNX.4.44.0310171441530.3108-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0310171501360.2831@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0310171441530.3108-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003, Rik van Riel wrote:

> On Fri, 17 Oct 2003, Randy.Dunlap wrote:
> 
> > then I wait for 1-2 minutes and hit the power button.
> > This is on an IBM dual-proc P4 (non-HT) with 1 GB of RAM.
> > 
> > Has anyone else seen this?  Suggestions or fixes?
> 
> Chances are the 8kB stack window isn't 8kB aligned in the
> fixmap area, because of other patches interfering.  Try
> adding a dummy fixmap page to even things out.

Check the email with subject;
[PATCH][2.6] Fix 4G/4G and WP test lockup

Another thing is, you shouldn't be branching off to that test! Which gcc 
compiler are you using?
