Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTKAQvo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 11:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTKAQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 11:51:44 -0500
Received: from 015.atlasinternet.net ([212.9.93.15]:54236 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S263120AbTKAQvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 11:51:42 -0500
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Synaptics losing sync
Date: Sat, 1 Nov 2003 17:51:39 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311011751.39610.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent this report before. 

I repeat it just in case someone found a workaround, and because 
2.6.0-test9 gives other related errors as well (TSC error):

...
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 4th byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.
Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
Synaptics driver lost sync at 1st byte
...

The laptop is a Dell X200 with APM and cpufreq enabled, and IO-apic 
disabled.

I tested with and w/o preemptive kernel and cpufreq with the same results. 

I also tried with 2.6.0-test9-bk4 (after last psmouse changes). I also 
tried modifying the sources and decreasing the synaptics' 80 packets per 
seconds to 40 packets but I still get the same errors.

Regards,

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

