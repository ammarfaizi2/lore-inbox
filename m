Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUELER0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUELER0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 00:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbUELER0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 00:17:26 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:13733 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264965AbUELERY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 00:17:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Why pass pt_regs throughout the input system?
Date: Tue, 11 May 2004 23:04:50 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405112304.50413.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question - why do we have to pass pt_regs structure throughout
entire input system? As far as I can tell it is a snapshot of all registers
that is done at the keyboard interrupt time and it is not used for anything
but for displaying this data when requested by SysRq.

Would it be wrong to save it by the hardware driver at interrupt time into a
structure accessible by keyboard.c? I do not think it matters if the data
shown by SysRq comes from interrupt other than one that serves keyboard...

Although it is somewhat a domain violation I do not think it is worse than
fattening interface to pass information that is not needed by most of its
users.  

-- 
Dmitry
