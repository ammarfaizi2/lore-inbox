Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVJZAPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVJZAPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVJZAPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:15:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:52454 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932492AbVJZAO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:14:59 -0400
Subject: [PATCH 00/02] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 17:07:40 -0700
Message-Id: <1130285260.10680.194.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, all,

	Is there any reason this patch could not go for a spin in a -mm tree?
It's similar to Guillaume's fork connector patch which did appear in -mm
at one point. It replaces the fork_advisor patch that ELSA is currently
using, can be used by userspace CKRM code, and in general is useful for
anything that may wish to monitor changes in all processes.

	I've modified the patch to future-proof it against proposed interfaces
that call module functions from fork, exit, exec, and set[ug]id paths.
This means that it should be safe to merge without or prior to merging
of those interfaces.

The patches are:
	
1. Export Connector Symbol - a small patch to export a useful connector
symbol. This enables the following patch.

2. Process Events Connector - This adds connector calls in the fork,
exec, etc. paths and provides a means for userspace to listen for the
generated events.

Thanks,
	-Matt Helsley
	< matthltc @ us.ibm.com >

