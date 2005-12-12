Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVLLP7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVLLP7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVLLP7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:59:24 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:29666 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932072AbVLLP7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:59:23 -0500
Date: Mon, 12 Dec 2005 07:58:47 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: miklos@szeredi.hu, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk, ak@suse.de,
       ashok.raj@intel.com
Subject: Re: [PATCH] move pm_power_off and pm_idle declaration to common
 code
Message-Id: <20051212075847.99a2591c.pj@sgi.com>
In-Reply-To: <m1pso29z37.fsf@ebiederm.dsl.xmission.com>
References: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu>
	<m1pso29z37.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A key question is how do we handle architectures
> that always want to want to call machine_power_off.

One common way to handle a generic default with possible arch specific
overrides is with #ifdef symbols.  Surround the generic definition with
something like "#ifndef ARCH_HAS_PM_POWER_OFF", and let the arch's that
want something other than the default define that preprocessor symbol
as well.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
