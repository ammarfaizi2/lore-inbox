Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVKSTBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVKSTBB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVKSTBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:01:00 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:18575 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750741AbVKSTBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:01:00 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Does Linux support powering down SATA drives?
Date: Sat, 19 Nov 2005 19:00:12 +0000
User-Agent: KMail/1.9
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain>
In-Reply-To: <1132426887.19692.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511191900.12165.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 November 2005 19:01, Alan Cox wrote:
> On Sad, 2005-11-19 at 09:41 -0800, Marc Perkel wrote:
> > Trying to save power consumption. I have a backup drive that is used
> > only once a day to back up the main drive. So - why should I run it more
> > that 10 minutes a day? What I'd like to do is keep it in an off state
> > and then at night power it on, mount it up, do the backup, unmount it,
> > and shut it down. Can I do that?
>
> SATA not yet, USB you could however.

Or PATA, of course. I switch off two of my HDs 4 minutes after last use with 
the commands:

hdparm -S 48 /dev/hde
hdparm -S 48 /dev/hdg

Isn't there a passthru patch in the works to let commands, such as the one 
required for suspend, through to a SATA device?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
