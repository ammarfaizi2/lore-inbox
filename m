Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265218AbUEMWmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUEMWmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUEMWmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:42:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:12523 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S265218AbUEMWkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:40:37 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.3  (F2.71; T1.001; A1.60; B2.21; Q2.21)
From: "Joey Dewille" <joey1968@fastmail.co.uk>
To: linux-kernel@vger.kernel.org
Date: Fri, 14 May 2004 00:30:45 +0200
X-Sasl-Enc: x5/qh94l56ZSOXX6OTAo2A 1084487445
Message-Id: <1084487445.25042.196432875@webmail.messagingengine.com>
Subject: how to deduce connect/accept history from struct sock? (REPEAT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Say a module is inserted that intercepts all socket operations and
it happened in the middle of several established connections.
Please answer what fields in struct sock or elsewhere can be examined
to determine reliably if the current established connections had been
accepted (i.e. accept call) or initiated (i.e. connect) from the local
machine.
--Joey

P.S. By the way, it seems to me that many fundamental structs in the 
linux kernel such as sock, task_struct and others waste memory --
it would be preferable to pack some of their members in
bitfields. Everything and the kitchen sink can be found in those 
structs which is wrong. Booleans are often given an entire char field.
Other members do not fall on natural alignment boundaries and create
holes. Memory is cheap but smaller memory footprint implies better
locality of reference, implies greater cache induced performance overall.

-- 
http://www.fastmail.fm - Consolidate POP email and Hotmail in one place
