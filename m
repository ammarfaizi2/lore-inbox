Return-Path: <linux-kernel-owner+w=401wt.eu-S1750755AbXANA6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbXANA6J (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbXANA6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:58:09 -0500
Received: from ozlabs.org ([203.10.76.45]:49961 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbXANA6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:58:08 -0500
Subject: Re: [patch 09/20] XEN-paravirt: dont export paravirt_ops
	structure, do individual functions
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <20070113014648.000988681@goop.org>
References: <20070113014539.408244126@goop.org>
	 <20070113014648.000988681@goop.org>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 11:57:56 +1100
Message-Id: <1168736276.8692.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-12 at 17:45 -0800, Jeremy Fitzhardinge wrote:
> Wrap the paravirt_ops members we want to export in wrapper functions.

Andrew, the removal of paravirt_ops export here will break kvm.  Feel
free to re-add "EXPORT_SYMBOL_GPL(paravirt_ops)" at the bottom of
arch/i386/kernel/paravirt.c; I'm working on a cleaner way for modules
like kvm / lguest (which want to use the native versions directly
anyway).

Thanks,
Rusty.


