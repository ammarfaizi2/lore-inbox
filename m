Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbRCaWB2>; Sat, 31 Mar 2001 17:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132501AbRCaWBS>; Sat, 31 Mar 2001 17:01:18 -0500
Received: from q.bofh.de ([212.126.200.160]:28689 "EHLO q.bofh.de")
	by vger.kernel.org with ESMTP id <S132503AbRCaWBI>;
	Sat, 31 Mar 2001 17:01:08 -0500
Date: Sat, 31 Mar 2001 23:48:23 +0200
From: Christian Kurz <shorty@getuid.de>
To: linux-kernel@vger.kernel.org
Subject: Assumption in sym53c8xx.c failed
Message-ID: <20010331234823.B1858@seteuid.getuid.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Organization: set_eugid(getuid(), getgid())
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently running 2.4.2-ac28 and today I got a failing assumption in
sym53c8xx.c. I'm not sure about the exact steps that I did to produce
this error, but it must have been something like: cdparanoia -blank=all,
then sending Ctrl+C to this process and after it's been killed
cdparanoia -blank=fast. I then got assertion: k!=-1 failed. But I found
no hint about this in the messages or syslog file. So I looked through
sym53c8xx.c to find this code and it seems like line 10123 is
responsible for creating this error and kernel panic. Should this be the
normal behaviour or is this a bug in the code?

Christian
-- 
Truth is the most valuable thing we have -- so let us economize it.
                -- Mark Twain
