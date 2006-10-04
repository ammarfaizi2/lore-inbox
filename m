Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWJDAH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWJDAH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWJDAH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:07:28 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:16832 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S1030415AbWJDAH1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:07:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: System hang problem.
Date: Tue, 3 Oct 2006 17:07:25 -0700
Message-ID: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5FE@US01WEMBX1.internal.synopsys.com>
Thread-Topic: System hang problem.
Thread-Index: AcbnRJu1LBdx5NQbTgCPHCaeWtOTMwAAz4cA
From: "Manish Neema" <Manish.Neema@synopsys.com>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2006 00:07:26.0443 (UTC) FILETIME=[13060BB0:01C6E749]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Keith for the response.

My explanation earlier is not clear. The "automount" process dying with
restrictive overcommit settings is not because of the OOM kill. It looks
like some bug with "automount" binary itself causing it to exit when it
could not service a new request.

"cd /remote/something" when the system is out of (allocate'able) memory
causes the below events (obtained from /var/log/messages)

Oct  3 13:35:32 gentoo036 automount[2060]: handle_packet_missing: fork:
Cannot allocate memory
Oct  3 13:35:34 gentoo036 automount[2060]: can't unmount /remote

And then the automount process for /remote mount disappears, which
should not happen.

Thanks anyways, I'll try to take it up with RedHat again...

-Manish 


