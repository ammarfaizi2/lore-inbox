Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTE1P4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264784AbTE1P4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:56:08 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:30512 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264783AbTE1P4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:56:02 -0400
Subject: [BUG] 2.5.70 tty_register_driver
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054138158.2107.4.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 May 2003 11:09:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There was a large patch applied in 2.5.70 to
the tty layer that has broken registration of tty
devices.

The tty drivers I maintain get a success return
value from tty_register_driver() and dynamic
major/minor device numbers are assigned, but
it does not appear to actually create the
char devices. (They do not show up in proc/devices).

I'm trying to dig through this and understand the
purpose of the changes, but it might be
more informative if the person responsible for the
patch would explain the purpose and what modification
of tty drivers are necessary to work with the changes.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


