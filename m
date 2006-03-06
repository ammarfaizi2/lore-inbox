Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWCFIAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWCFIAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWCFIAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:00:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752038AbWCFIAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:00:34 -0500
Date: Mon, 6 Mar 2006 03:00:10 -0500
From: Dave Jones <davej@redhat.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Al Viro <viro@ftp.linux.org.uk>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-ID: <20060306080010.GJ21445@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Al Viro <viro@ftp.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net> <20060306072346.GF27946@ftp.linux.org.uk> <20060306072823.GF21445@redhat.com> <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 09:56:22AM +0200, Pekka Enberg wrote:
 > On 3/6/06, Dave Jones <davej@redhat.com> wrote:
 > > I wonder if we could get away with something as simple as..
 > >
 > > #define kfree(foo) \
 > >         __kfree(foo); \
 > >         foo = KFREE_POISON;
 > >
 > > ?
 > 
 > It's legal to call kfree() twice for NULL pointer. The above poisons
 > foo unconditionally which makes that case break I think.

Bah, I never did like that rule.

		Dave

-- 
http://www.codemonkey.org.uk
