Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbTI2PlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTI2PlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:41:07 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:26586 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263616AbTI2PlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:41:04 -0400
Date: Mon, 29 Sep 2003 08:40:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: david@2gen.com
Subject: [Bug 1280] New: Reading ACPI info from /proc filesystem	pauses system
Message-ID: <39470000.1064850011@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Reading ACPI info from /proc filesystem pauses system
    Kernel Version: 2.6.0-test6
            Status: NEW
          Severity: normal
             Owner: len.brown@intel.com
         Submitter: david@2gen.com


Distribution: Debian Unstable (sid)
Hardware Environment: IBM Thinkpad G40

Problem Description:
Now that I've got ACPI working thanks to bug #1265 I've got another problem. If
battery and ac power status is read from the proc filesystem, the computer
"freezes" shortly, causing the mouse pointer to jerk etc.

For reproducing this, try something like this:
while [[ 1 ]]; do
    cat /proc/acpi/ac_adapter/AC/*;
    cat /proc/acpi/battery/BAT1/*;
    sleep 1
done

Now you may wonder, why do such a thing? Battery status applet as shipped with
gnome (and probably many other similar apps) read these values once a second,
making the system annoying to use as mouse and applications are sluggish.


