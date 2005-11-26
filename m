Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVKZPjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVKZPjC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 10:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVKZPjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 10:39:01 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:10756 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932254AbVKZPjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 10:39:00 -0500
Date: Sat, 26 Nov 2005 16:40:25 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Paused I/O versus regular I/O
Message-Id: <20051126164025.66aae4f4.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Could anyone tell me what the difference is between "paused" I/O
(inb_p, oub_p and friends) and regular I/O (inb, oub and friends)? I
understand that the former includes some delays here and there, but how
do I know when to use the paused variant, and when the non-paused
variant is OK?

The driver I am currently working on involves combined I/O access on
the Super-I/O ports (0x2e and 0x2f being the address and data ports,
respectively) and chip-specific combined I/O access (typically 0x295 and
0x296 being the address and data ports, respectively). I am using
regular (non-paused) I/O and it seems to work well, but I was wondering
if maybe combined I/O (when you write to a port to select an internal
address, then read the data from another port) was supposed to be done
using paused I/O.

Can anyone clarify the situation? I couldn't find any documentation
explaining *when* paused I/O must be used.

Thanks,
-- 
Jean Delvare
