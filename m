Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUBYQOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUBYQOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:14:42 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:18631 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261388AbUBYQNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:13:30 -0500
Date: Wed, 25 Feb 2004 11:13:17 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Len Brown <len.brown@intel.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [RFC] ACPI power-off on P4 HT
In-Reply-To: <1077695701.5911.130.camel@dhcppc4>
Message-ID: <Pine.LNX.4.58.0402251110250.30536@montezuma.fsmlabs.com>
References: <1076145024.8687.32.camel@dhcppc4>  <20040208082059.GD29363@alpha.home.local>
  <20040208090854.GE29363@alpha.home.local>  <20040214081726.GH29363@alpha.home.local>
  <1076824106.25344.78.camel@dhcppc4>  <20040225070019.GA30971@alpha.home.local>
 <1077695701.5911.130.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Len Brown wrote:

> Willy,
> I do think we need a generic way to be sure that certain routines are
> run only on cpu0.

set_cpus_allowed?

> I don't see it in the ACPI spec, but it seems that on some platforms,
> some register accesses (such as writing to the sleep control reg) are
> reliable only when accessed from cpu0.
>
> This issue has been with us for some time:
> http://bugzilla.kernel.org/show_bug.cgi?id=1141
>
> I am hopeful that the prepare-shutdown sequence you suggest below will
> not be necessary.
