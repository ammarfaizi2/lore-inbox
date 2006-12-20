Return-Path: <linux-kernel-owner+w=401wt.eu-S1751072AbWLTIKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWLTIKp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 03:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLTIKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 03:10:44 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46540 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbWLTIKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 03:10:44 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4588EFE9.1010102@s5r6.in-berlin.de>
Date: Wed, 20 Dec 2006 09:10:17 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] Add driver for OHCI firewire host controllers.
References: <fa.4xX+iXSBwItlW4ONHWvAYR6m5+c@ifi.uio.no> <4588BA0E.1080801@shaw.ca>
In-Reply-To: <4588BA0E.1080801@shaw.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> How about suspend/resume support? Lots of laptops have OHCI 1394 and
> full suspend/resume support is something that the current ohci1394
> driver lacks.

To be precise, ohci1394 itself does suspend/resume now thanks to
Bernhard Kaindl's patch from September.  (Merged in 2.6.20-rc1.)  But
the mid layer and perhaps some of the high-level drivers need additional
support.  According to a report, ieee1394 does not restore the local
config ROM yet.  I will join working on this problem RSN.  I think these
issues are not particularly difficult to solve --- it is merely that the
few people who know the driver stack well enough didn't use suspend/
resume support on their own machines yet.

As for Kristian's stack, suspend/resume support can probably be added
quite easily, especially after I got the missing bits working in the
mainline stack.
-- 
Stefan Richter
-=====-=-==- ==-- =-=--
http://arcgraph.de/sr/
