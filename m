Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTDHFLl (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 01:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbTDHFLl (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 01:11:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:54661 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263945AbTDHFLk (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 01:11:40 -0400
Date: Mon, 07 Apr 2003 22:23:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 551] New: CONFIG_INPUT should be "y" by default
Message-ID: <9360000.1049779393@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=551

           Summary: CONFIG_INPUT should be "y" by default
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: vojtech@suse.cz
         Submitter: michael.wardle@adacel.com


Problem Description:
When attempting to build a 2.5.66 kernel, CONFIG_INPUT is "m" by default.  This
hides configuration items such as CONFIG_VT, without which the new kernel will
not have a console.  As a working console is a basic feature that I expect most
users will want, I suggest both CONFIG_INPUT and CONFIG_VT be "y" by default.

---------------------------- NOTE -----------------------

Above was the bug as filed.

CONFIG_INPUT and CONFIG_VT *do* default to y.
Unfortunately 2.4 configs have CONFIG_INPUT disabled, which overrides
the default ;-( This is breaking far too many people ... we really 
need to do something like make CONFIG_INPUT_DISABLE and flip the 
logic instead, so people stop tripping over this. Too much upgrade
pain.

M.

