Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUHVW6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUHVW6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHVW6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:58:39 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:30471 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S267632AbUHVW6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:58:36 -0400
Date: Mon, 23 Aug 2004 00:58:33 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cursed Checksums
Message-ID: <20040822225833.GA5225@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <1093174820.24319.60.camel@localhost.localdomain> <S268085AbUHVUD4/20040822200356Z+207@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S268085AbUHVUD4/20040822200356Z+207@vger.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 11:03:54PM +0200, Josan Kadett wrote:
> Perhaps there is a way to recompute IP header checksums before they get into
> the interface? As I outlined, I have found a way to manipulate IP source
> address before the packet is flushed to system, but a means of recalculating
> the IP header checksum after that manipulation should be found. Because even
> if I ignore IP header CRC in one system, all other boxes connected to this
> machine has to be patched the same. That is impossible anyway.
> 
> Only if I could find a way to recalculate the checksum in IP headers by
> doing a simple hack to the kernel, everything would be alright. 

Why don't you patch the checksum when you change the IP?  It's just a
not of the sum the 16-bit words so take the old one, not it, add the
two 16-bits differences, re-not it and write it back.

  OG.

