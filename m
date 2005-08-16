Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbVHPMcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVHPMcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVHPMcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:32:54 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:45065 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S932682AbVHPMcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:32:54 -0400
Message-ID: <4301DCC1.5060409@stud.feec.vutbr.cz>
Date: Tue, 16 Aug 2005 14:32:01 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.13-rc6-rt1
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com> <20050815111804.GA26161@elte.hu> <20050816084116.GA16772@elte.hu>
In-Reply-To: <20050816084116.GA16772@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------010201020801090805080707"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (0.1 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -0.6 BAYES_01               BODY: Bayesian spam probability is 1 to 10%
                              [score: 0.0279]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201020801090805080707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i've released the 2.6.13-rc6-rt1 tree, which can be downloaded from the 
> usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> as the name already suggests, i've switched to a new, simplified naming 
> scheme, which follows the usual naming convention of trees tracking the 
> mainline kernel. The numbering will be restarted for every new upstream 
> kernel the -RT tree is merged to.

Great! With this naming scheme it is easy to teach Matt Mackall's 
ketchup script about the -RT tree.
The modified ketchup script can be downloaded from:
http://www.uamt.feec.vutbr.cz/rizeni/pom/ketchup-0.9+rt

Matt, would you release a new ketchup version with this support for 
Ingo's tree?

Michal

--------------010201020801090805080707
Content-Type: text/plain;
 name="ketchup-rt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ketchup-rt.diff"

--- ketchup-0.9	2005-08-16 14:06:20.000000000 +0200
+++ ketchup-0.9+rt	2005-08-16 14:24:05.000000000 +0200
@@ -307,7 +307,11 @@ version_info = {
     '2.6-mjb': (latest_mjb,
                  kernel_url + "/people/mbligh/%(prebase)s/patch-%(full)s.bz2",
                  r'patch-(2.6.*?).bz2',
-                 1, "Martin Bligh's random collection 'o crap")
+                 1, "Martin Bligh's random collection 'o crap"),
+    '2.6-rt': (latest_dir,
+                "http://people.redhat.com/mingo/realtime-preempt/patch-%(full)s",
+		r'patch-(2.6.*?)',
+		0, "Ingo Molnar's realtime-preempt kernel")
     }
 
 def version_url(ver, sign = 0):

--------------010201020801090805080707--
