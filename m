Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTEaPjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTEaPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:39:22 -0400
Received: from imsantv20.netvigator.com ([210.87.250.76]:12983 "EHLO
	imsantv20.netvigator.com") by vger.kernel.org with ESMTP
	id S264354AbTEaPjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:39:20 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
Date: Sat, 31 May 2003 23:52:15 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305311047110.20941-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305311047110.20941-100000@chimarrao.boston.redhat.com>
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305312348.42499.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 22:48, Rik van Riel wrote:
>
> Today I finally merged rmap15j forward to marcelo's latest
> release.  The IO stall fixes should be especially interesting:
>

Patched rc6 ex BK OK and compiled with gcc295-3 OK

On a P4/533-2.4Ghz/512MB with udma5 IDE ~50MB/s:

Shows severe interactivity problems and hangs

Scroll and mouse hangs and delayed response to keyboard 
greater 1s are easily observable.

Test script: tstinter V0.1 

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/1291.html

To reproduce cd to dir with script and execute from X console: 
  ./tstinter start

More instructions in script

Other kernel results: 
   2.4.18 PIO DIES - see msg w. script, 
   2.4.18 udma2 OK, 
   2.4.19 Bad, 
   2.4.20 Bad, 
   2.4.21-rc1 Bad, 
   2.4.21-rc6 OK 
   2.5.70,-mm1,-mm2,-mm3 (OK) 

Regards
Michael

