Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVIDQU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVIDQU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbVIDQU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 12:20:56 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:24745 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750907AbVIDQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 12:20:55 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
Subject: Re: [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 17:20:55 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041720.55588.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 12:05, Giampaolo Tomassoni wrote:
> Dears,
>
> thanks to Jiri Slaby who found a bug in the AAL0 handling of the ATMSAR
> module.
>
> I attach a fixed version of the atmsar patch as a diff against the 2.6.13
> kernel tree.
>
[snip]

Just out of curiosity, is there ANY reason why this has to be done in the 
kernel? The PPPoATM module for pppd implements (via linux-atm) a completely 
userspace ATM decoder.. if anything, now redundant ATM stack code should be 
REMOVED from Linux!

Most distributions (to my knowledge) supporting the speedtouch modem do so 
using the method prescribed on speedtouch.sf.net; an entirely userspace 
procedure. pppd does all the ATM magic.

Does this have real-world applications beyond the Speedtouch DSL modems? If 
not, I propose adding this code to linux-atm, not the kernel, since most 
users of USB speedtouch DSL modems will not be using the kernel's ATM.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
