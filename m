Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVIENsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVIENsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVIENsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:48:09 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:12012 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932280AbVIENsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:48:08 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [ATMSAR] Request for review - update #1
Date: Mon, 5 Sep 2005 14:52:20 +0100
User-Agent: KMail/1.8.90
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it> <200509041720.55588.s0348365@sms.ed.ac.uk> <1125912996.6146.103.camel@baythorne.infradead.org>
In-Reply-To: <1125912996.6146.103.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051452.21075.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 10:36, David Woodhouse wrote:
> On Sun, 2005-09-04 at 17:20 +0100, Alistair John Strachan wrote:
> > Just out of curiosity, is there ANY reason why this has to be done in the
> > kernel? The PPPoATM module for pppd implements (via linux-atm) a
> > completely userspace ATM decoder.. if anything, now redundant ATM stack
> > code should be REMOVED from Linux!
>
> No. The pppoatm module for pppd uses the kernel ATM stack and kernel
> PPPoATM functionality. I suspect you're thinking of the pseudo-tty hack
> used by the userspace code.

I'm not sure which module you're referring to, but the patch recommended by 
the speedtouch people links to linux-atm, and does not require kernel ATM or 
kernel pppoatm functionality, or use any kernel modules. I do notice it does 
a system ("/sbin/modprobe pppoatm"); but this is definitely not required; I'm 
speaking to you from a speedtouch DSL connection, no module loaded or 
compiled in, no ATM support in the kernel.

http://devzero.co.uk/~alistair/linuxmisc/ppp-2.4.3-atm.diff

>
> > Most distributions (to my knowledge) supporting the speedtouch modem do
> > so using the method prescribed on speedtouch.sf.net; an entirely
> > userspace procedure. pppd does all the ATM magic.
>
> Fedora doesn't; it uses the kernel driver.

I stand corrected.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
