Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVIAGuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVIAGuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVIAGuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:50:07 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:49110 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932495AbVIAGuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:50:05 -0400
Subject: Re: reboot vs poweroff (was: Linux 2.6.13)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <20050901062406.EBA5613D5B@rhn.tartu-labor>
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1125557333.12996.76.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 01 Sep 2005 16:48:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-09-01 at 16:24, Meelis Roos wrote:
> RD> Well, there aren't many differences between 2.6.13-rc7 and 2.6.13.  If
> RD> I had to guess, I would bet the commit below is what broke you.  I'm
> RD> including a patch that reverts it at the end of this email
> 
> Nigel, have you tried reverting the patch Roland pointed out? It
> probably helps you.
> 
> I am also interested in this but in another way - the fix fixed reboot
> for me (and at least one more person) and just plain reverting it will
> break it again. Some better fix will probably be needed.

I've since found that in the suspend2 code, I was working around this
problem before by not calling the prepare method. I've just today
modified the Suspend code so that it calls prepare for all of the
powerdown methods and everything is working fine without reverting the
patch. I guess this is your better fix if you're a suspend2 user. If
not, are there other circumstances in which you're seeing the computer
fail to powerdown?

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

