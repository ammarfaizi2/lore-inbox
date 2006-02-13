Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWBMToK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWBMToK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWBMToK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:44:10 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:45298 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964776AbWBMToJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:44:09 -0500
Message-ID: <43F0E284.2040805@gentoo.org>
Date: Mon, 13 Feb 2006 19:48:20 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060207)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16, sk98lin out of date
References: <200602131058.03419.s0348365@sms.ed.ac.uk> <20060213110542.GZ3927@mea-ext.zmailer.org> <200602131110.34212.s0348365@sms.ed.ac.uk>
In-Reply-To: <200602131110.34212.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> Thanks Matti, I wasn't even aware of this driver. Might I suggest the
> "old" driver be marked as such in Linux 2.6.16. I guess I must've
> skipped over it because it begins with "New", and does not contain
> the word "Marvell", which is indicated exclusively by lspci.

I changed the help text of all 3 drivers (sk98lin/skge/sky2) to
point out which ones are/aren't interchangable in 2.6.16. The situation 
is a little confusing.

The reason that the sk98lin diff is so huge is because SysKonnect
effectively added support for a substantially different range of cards
(Yukon-2) into the existing driver. This is far from the driver quality
required for the kernel today, so Stephen Hemminger (skge author) wrote 
a new driver (sky2) for the Yukon-2 range.

The long term plan is to obsolete and remove sk98lin, but we aren't 
ready yet: skge issues pop up every month or two, and sky2 is young. 
Stephen's own words:

> I applaud the initiative, but this it is too premature to obsolete
> the existing driver. There may be lots of chip versions and other
> variables that make the existing driver a better choice.

Daniel
