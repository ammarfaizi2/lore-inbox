Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWIMB4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWIMB4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWIMB4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:56:08 -0400
Received: from gw.goop.org ([64.81.55.164]:2243 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751490AbWIMB4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:56:05 -0400
Message-ID: <45076529.6040106@goop.org>
Date: Tue, 12 Sep 2006 18:55:53 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: cpufreq@lists.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.18-rc6-mm2] sw_any_bug_dmi_table can be used on resume,
 so it isn't initdata
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sw_any_bug_dmi_table can be used on resume, so it isn't initdata.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff -r 3bf6c0c79dba arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	Tue Sep 12 01:37:21 2006 -0700
+++ b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	Tue Sep 12 18:51:41 2006 -0700
@@ -393,7 +393,7 @@ static int __init sw_any_bug_found(struc
 }
 
 
-static struct dmi_system_id __initdata sw_any_bug_dmi_table[] = {
+static struct dmi_system_id sw_any_bug_dmi_table[] = {
 	{
 		.callback = sw_any_bug_found,
 		.ident = "Supermicro Server X6DLP",


