Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVLFFKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVLFFKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVLFFKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:10:21 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15534 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751354AbVLFFKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:10:21 -0500
Subject: [RFC][PATCH 000/002]  Add timestamp to process event connector
	message
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 21:00:25 -0800
Message-Id: <1133845225.25202.1373.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This series of patches adds a timestamp field to the events sent
via the process event connector. The timestamp allows listeners to
accurately account the duration(s) between a process' events and offers
strong means with which to determine the order of events while also
avoiding the addition of per-task data.

Series:

getnstimestamp.patch
proc-events-timestamp.patch

	The first patch adds a new generic function, getnstimestamp(),
which gets an SMP-safe high-resolution monotonic timestamp.

	The second patch adds a timestamp field to the events sent via
the process event connector and fills the field using the new timestamp
function. It alters the size and layout of the event structure and hence
would break compatibility if not incorporated with the first release of
process events connector in a mainline kernel.

Cheers,
	-Matt Helsley

