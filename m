Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWAFCLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWAFCLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWAFCLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:11:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932545AbWAFCLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:11:38 -0500
Date: Thu, 5 Jan 2006 16:28:02 -0500
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dual line backtraces for i386.
Message-ID: <20060105212802.GR20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200601051321_MC3-1-B55B-8147@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601051321_MC3-1-B55B-8147@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:18:32PM -0500, Chuck Ebbert wrote:

 > > -                     printk("\n");
 > > +                     if (space == 0) {
 > > +                             printk("    ");
 > > +                             space = 1;
 > > +                     } else {
 > > +                             printk("\n");
 > > +                             space = 0;
 > > +                     }
 > 
 > Why not:
 > 
 >                         printk(space == 0 ? "     " : "\n");
 >                         space = !space;

readability ?
Personally, I despise the ternary operator, because it makes me
stop to try to parse it every time I see it.  With the code I wrote
it's blindlingly obvious what is going on.

		Dave

