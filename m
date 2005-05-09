Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVEITfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVEITfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEITfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:35:42 -0400
Received: from fmr20.intel.com ([134.134.136.19]:929 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261491AbVEITfh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:35:37 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/4] rt_mutex: add new plist implementation
Date: Mon, 9 May 2005 12:35:13 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0335DBE0@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/4] rt_mutex: add new plist implementation
Thread-Index: AcVUo/YhG+Sc0UY3QISmqWvOIKDnMAAKX4+Q
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Oleg Nesterov" <oleg@tv-sign.ru>, "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 09 May 2005 19:35:15.0868 (UTC) FILETIME=[39BE0DC0:01C554CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Oleg

>From: Oleg Nesterov

>+extern void plist_add(struct pl_node *node, struct pl_head *head);
>+extern void plist_del(struct pl_node *node);

At least I'd add return codes for this if the head's priority 
changes (or in this case, because head's have no prio, if the 
first node's  prio change). Both function's  logic should make
it easy to test and it'd save a lot of code in the caller.

-- Inaky
