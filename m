Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbTCVKUU>; Sat, 22 Mar 2003 05:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262092AbTCVKUU>; Sat, 22 Mar 2003 05:20:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38660 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262085AbTCVKUT>; Sat, 22 Mar 2003 05:20:19 -0500
Date: Sat, 22 Mar 2003 10:31:21 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4+ptrace exploit fix breaks root's ability to strace
Message-ID: <20030322103121.A16994@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are the authors of the ptrace patch aware that, in addition to closing the
hole, the "fix" also prevents a ptrace-capable task (eg, strace started by
root) from ptracing user threads?

For example, you can't strace vsftpd processes started from xinetd.

Is this intended behaviour?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

