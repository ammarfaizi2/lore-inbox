Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUHTPlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUHTPlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHTPlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:41:15 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:63921
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S268267AbUHTPlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:41:08 -0400
Message-Id: <s12629a3.088@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Fri, 20 Aug 2004 17:41:22 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: x86: NMI vs. MCE handling
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, care is being taken to deal with the potential of an NMI
being signalled at the very moment when the debug fault is correcting
the stack for the sysenter path, or when in at the stack pointer load in
the sysenter path itself. The same care, however, is not taken in the
MCE code path, and since I'd consider this equally important (especially
when the event is correctable) I wonder whether this is an oversight or
I'm misunderstanding something.

Thanks for a clarification,
Jan
