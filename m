Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbULWNLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbULWNLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 08:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbULWNLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 08:11:37 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:60079 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261227AbULWNLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 08:11:35 -0500
Date: Thu, 23 Dec 2004 14:11:35 +0100
From: bert hubert <ahu@ds9a.nl>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pc stalling when processing large files [2.6.9]
Message-ID: <20041223131135.GA11257@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Folkert van Heusden <folkert@vanheusden.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0412231205470.28376-100000@muur.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0412231205470.28376-100000@muur.intranet.vanheusden.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 12:09:10PM +0100, Folkert van Heusden wrote:
> Hi,
> 
> I have a P-III with 384MB of ram running kernel 2.6.9. It has one IDE disk.
> When processing a large mailbox with sa-learn (the bayes learn tool of
> spamassassin), the system gets very unresponsive. Like: when typing commands
> on it via ssh, the system doesn't respond several times for seconds (1 or 2
> maybe 3). Then when I continue to type, it gets a little better but when
> idling for say 10 seconds it gets unresponsive again. The large mailbox is
> aprox 200MB.

Sounds obvious, but can you show the output of hdparm /dev/hda ? You have
IDE DMA support enabled, but does the kernel recognize your IDE controller?

What you describe vould very well be caused by DMA being switched off for
IDE.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
