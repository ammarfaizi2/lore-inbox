Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWBFUBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWBFUBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWBFUBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:01:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7042 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932348AbWBFUBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:01:37 -0500
Date: Mon, 6 Feb 2006 12:01:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: ak@suse.de, clameter@engr.sgi.com, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206120109.0738d6a2.pj@sgi.com>
In-Reply-To: <20060206184330.GA22275@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<200602061811.49113.ak@suse.de>
	<Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
	<200602061936.27322.ak@suse.de>
	<20060206184330.GA22275@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> we should default to local.

Agreed.  There is much software and systems management expectations
sitting on top of this, that have certain expectations of the default
memory placement behaviour, to a rough degree, of the system.

They are expecting node-local placement.

We would only change that default if it was shown to be substantially
wrong headed in a substantial number of cases.  It has not been
so shown.  It is either an adequate or quite desirable default for
most cases.

Rather we need to consider optional behaviour, for use on workloads
for which other policies are worth developing and invoking.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
