Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVCNPeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVCNPeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVCNPeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:34:12 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:29200 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261548AbVCNPdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:33:53 -0500
Date: Mon, 14 Mar 2005 10:33:25 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg Stark <gsstark@MIT.EDU>
Cc: Andrew Morton <akpm@osdl.org>, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Message-ID: <20050314153323.GA7801@tuxdriver.com>
Mail-Followup-To: Greg Stark <gsstark@MIT.EDU>,
	Andrew Morton <akpm@osdl.org>, s0348365@sms.ed.ac.uk,
	linux-kernel@vger.kernel.org, pmcfarland@downeast.net
References: <87u0ng90mo.fsf@stark.xeocode.com> <200503130152.52342.pmcfarland@downeast.net> <874qff89ob.fsf@stark.xeocode.com> <200503140103.55354.s0348365@sms.ed.ac.uk> <87sm2y7uon.fsf@stark.xeocode.com> <20050313200753.20411bdb.akpm@osdl.org> <87br9m7s8h.fsf@stark.xeocode.com> <87zmx66b2b.fsf@stark.xeocode.com> <87u0nevc11.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0nevc11.fsf@stark.xeocode.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 03:59:06AM -0500, Greg Stark wrote:

> Well, I built a slew of kernels but found it on the first reboot.
> 
> 2.6.7 doesn't work.
 
> > 2.6.7:

> > 	[sound/oss] remove bogus CIV_TO_LVI
> > 	
> > 	This patch removes a pair of bogus LVI assignments.  The explanation in
> > 	the comment is wrong because the value of PCIB tells the hardware that
> > 	the DMA buffer can be processed even if LVI == CIV.
> > 	
> > 	Setting LVI to CIV + 1 causes overruns when with short writes
> > 	(something that vmware is very fond of).

Pretty sure this is/was the problem.  I found this to be causing
a problem with Wolfenstein: Enemy Territory.  The patch to reverse
this change appears to have been merged into 2.6.11.  I suggest you
try that one. :-)

Good luck!

John
-- 
John W. Linville
linville@tuxdriver.com
