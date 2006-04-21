Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWDUOHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWDUOHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDUOHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:07:03 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:22258 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932305AbWDUOHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:07:00 -0400
Subject: Re: kfree(NULL)
From: Daniel Walker <dwalker@mvista.com>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604210322110.21429@d.namei>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	 <Pine.LNX.4.64.0604210322110.21429@d.namei>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 07:06:58 -0700
Message-Id: <1145628419.20843.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 03:22 -0400, James Morris wrote:
> On Fri, 21 Apr 2006, Daniel Walker wrote:
> 
> > 	I included a patch , not like it's needed . Recently I've been
> > evaluating likely/unlikely branch prediction .. One thing that I found 
> > is that the kfree function is often called with a NULL "objp" . In fact
> > it's so frequent that the "unlikely" branch predictor should be inverted!
> > Or at least on my configuration. 
> 
> It would be helpful to collect some stats on this so we can look at the 
> ratio.

On my system it was roughly 31 million kfree(NULL) calls, to 4 million
calls with other values . That was over 4 hours of run time .

Daniel

