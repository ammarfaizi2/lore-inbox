Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVETRH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVETRH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVETRH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:07:58 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:22931 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261509AbVETRHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:07:41 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116608144.29037.55.camel@localhost.localdomain>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
	 <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
	 <1116603414.29037.36.camel@localhost.localdomain>
	 <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
	 <1116608144.29037.55.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 20 May 2005 12:58:16 -0400
Message-Id: <1116608296.12489.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 17:55 +0100, David Woodhouse wrote:
> Yeah, basically. Although it would be better to introduce AUDIT_AVC_PATH
> instead of using AUDIT_AVC for the type. If there's general agreement
> this this is a sane answer, I'll stick it in the git tree. Can I see a
> Signed-off-by line please?

Patched kernel compiles, boots, and runs the selinux testsuite as
expected, with just the (last component) name= info in the avc message
and the path= info in the associated syscall audit message.  I don't
mind introducing an AUDIT_AVC_PATH type if desired, but saw that there
was an AUDIT_AVC definition that wasn't being used yet.  What do people
want?  Would we end up adding separate types for each kind of auxiliary
audit data provided by the AVC, or just put them all into a single top-
level type with possibly a subtype to distinguish.

-- 
Stephen Smalley
National Security Agency

