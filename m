Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312773AbSDFUNg>; Sat, 6 Apr 2002 15:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312790AbSDFUNf>; Sat, 6 Apr 2002 15:13:35 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:580 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S312773AbSDFUNd>; Sat, 6 Apr 2002 15:13:33 -0500
From: brian@worldcontrol.com
Date: Sat, 6 Apr 2002 12:09:18 -0800
To: linux-kernel@vger.kernel.org
Subject: more on 2.4.19pre... & swsusp
Message-ID: <20020406200918.GA1535@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a .config difference between my 2.4.19-pre5-ac3 setup
and my 2.4.19-pre6 (swsusp v0.8 patched) setup.

After making both the same, both generally oops in the same place
as previously reported (oops via ksymoops previously posted).

Findings thus far:

   swsusp says it doesn't need APM. But it does. at least so far
   as menuconfig is concerned.

   With apm loaded (or built) in the kernel swsusp says it can't
   terminate/kill kapmd and gives up.

   With apm *not* loaded in the kernel swsusp oopses as previously
   reported.

Nice repeatable behavior.

Documentation/swsusp.txt which is repeatedly refered to does not
exist, either in the ac version or the v0.8 patch.

I have not been able to find the swsusp program which is also
refered to.

-- 
Brian Litzinger <brian@worldcontrol.com>
