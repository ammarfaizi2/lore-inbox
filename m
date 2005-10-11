Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVJKA3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVJKA3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVJKA3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:29:44 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:51841 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751313AbVJKA3o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:29:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GTddg2VhvULD0v6KuTObLejGzJ9sYJ820yETS2EZpfz4rBoOMuRsz1pFjkEYQtVvnEkZkeFN/mI3u0Ik9LVF5Vf61EU8Qt0NN/6krTx1amUscGRXYXEL3WBUMh0ZLsTo0SXfXrGlaSviHirH4l4tQ+hLMTieeZG+Am9gBbg3Cyw=
Message-ID: <a44ae5cd0510101729x52f31063l6e9d4eec468963ec@mail.gmail.com>
Date: Mon, 10 Oct 2005 20:29:43 -0400
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>
Subject: 2.6.14-rc3-git8 -- Failed to execute /etc/init lang=us apm=power-off root=/dev/hda6 video=nvidiafb:1024x768 ro nomce. Attempting defaults...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the following in my kernel log output:
"Failed to execute /etc/init lang=us apm=power-off root=/dev/hda6
video=nvidiafb:1024x768 ro nomce.  Attempting defaults..."

I notice that a patch to generate this message was added in
2.6.14-rc3.  I don't understand the purpose of this patch, or whether
this error indicated some important problem with my Debian SID
configuration.
To see the patch, check here:
http://www.linuxhq.com/kernel/v2.6/14-rc3/init/main.c

A possibly related problem I am attempting to track down is that
nvidiafb is not correctly receiving it's video= option parameter. 
Specifically, I am using:
cat /proc/cmdline
"init=/etc/init lang=us apm=power-off root=/dev/hda6
video=nvidiafb:1024x768 ro nomce"
But nvidiafb is only seeing:
nvidiafb: mode_option = <NULL>

Any ideas?  Is this related?

Thanks!
         Miles
