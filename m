Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314648AbSD0Xz3>; Sat, 27 Apr 2002 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314649AbSD0Xz2>; Sat, 27 Apr 2002 19:55:28 -0400
Received: from ns.suse.de ([213.95.15.193]:62217 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314648AbSD0Xz1>;
	Sat, 27 Apr 2002 19:55:27 -0400
Date: Sun, 28 Apr 2002 01:55:13 +0200
From: Dave Jones <davej@suse.de>
To: J Sloan <joe@tmsusa.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5-dj merging status.
Message-ID: <20020428015513.B14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	J Sloan <joe@tmsusa.com>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427170737.GA29275@suse.de> <3CCB37D2.9050300@tmsusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 04:44:18PM -0700, J Sloan wrote:
 > Dave Jones wrote:
 > 
 > >+   numerous jiffy wrap fixes
 > >
 > Hello, would this include the fix for the
 > infamous 497 day uptime wraparound bug?

Different problem. This is a collection of fixes of the form..

-    while (jiffies < timeout);
+    while (time_before(jiffies, timeout));

And similiar.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
