Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVETRQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVETRQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVETRQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:16:17 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:62868 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261520AbVETRQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:16:11 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116608730.29037.60.camel@localhost.localdomain>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
	 <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
	 <1116603414.29037.36.camel@localhost.localdomain>
	 <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
	 <1116608730.29037.60.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 20 May 2005 13:06:47 -0400
Message-Id: <1116608807.12489.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 18:05 +0100, David Woodhouse wrote:
> It gets freed at this point too, not just in audit_free_aux(). So you
> have to do the mntput and dput here too.

Ah, good point.  Thanks for catching it.  I'll update the patch once I
get clarification on the other issues (type value, general struct).

-- 
Stephen Smalley
National Security Agency

