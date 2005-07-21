Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVGUPZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVGUPZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVGUPZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:25:05 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:60434 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261840AbVGUPYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:24:55 -0400
Message-ID: <42DFBE3F.20602@stud.feec.vutbr.cz>
Date: Thu, 21 Jul 2005 17:24:47 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Andreas Steinmetz <ast@domdv.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <42DD6AA7.40409@domdv.de> <42DD7011.6080201@stud.feec.vutbr.cz> <200507201115.08733.rjw@sisk.pl> <42DECB21.5020903@stud.feec.vutbr.cz> <20050721053126.GB5230@atrey.karlin.mff.cuni.cz> <42DF7C52.4020907@stud.feec.vutbr.cz> <20050721152053.GA21475@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050721152053.GA21475@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>I'm trying to do something similar for x86_64. See the attached patch.
>>Unfortunately, it doesn't help. The behaviour seems unchanged (resume 
>>still works iff amd64-agp wasn't loaded before suspend).
> 
> 
> Are you sure problem is on level4_pgt? We probably use constant
> level4_pgt but split pages at some deeper level. You may want try
> saving 3rd-level table, instead.

I'm not sure about that at all. That was just my attempt of cargocult 
programming :-)
OK, I'll try saving the 3rd-level table. It'll take me some time to 
figure out how to do that, however :-)

Michal
