Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUHIPgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUHIPgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUHIPdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:33:22 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36023 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266650AbUHIP3r (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:29:47 -0400
Date: Mon, 9 Aug 2004 17:29:44 +0200
From: bert hubert <ahu@ds9a.nl>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Linux-kernel@vger.kernel.org
Subject: Re: Cannot burn without strace on 2.6.8-rc3-mm1
Message-ID: <20040809152944.GA30412@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alexander Gran <alex@zodiac.dnsalias.org>,
	Linux-kernel@vger.kernel.org
References: <200408091649.20180@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091649.20180@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 04:49:17PM +0200, Alexander Gran wrote:

> Driveropts: 'burnfree'
> SCSI buffer size: 64512
> cdrecord: Cannot allocate memory. Cannot get SCSI I/O buffer.
> 
> However 
> strace cdrecord -v dev=/dev/hdc -dao driveropts=burnfree 
> -data /files/Pakete/KNOPPIX_V3.4-2004-05-17-DE.iso
> just works..Strange, um?

Try:
LD_ASSUME_KERNEL=2.4 cdrecord -v dev=/dev/hdc etc etc etc.

Not that this is correct, but if that helps it will have narrowed down the
problem. Also show 'ldd cdrecord' and 'ldd strace'.

I've seen a problem before that was solved by strace and it had to do with
the TLS NPTL stuff.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
