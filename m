Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVITVPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVITVPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVITVPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:15:09 -0400
Received: from mail.collax.com ([213.164.67.137]:10456 "EHLO
	kaber.coreworks.de") by vger.kernel.org with ESMTP id S965124AbVITVPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:15:07 -0400
Message-ID: <43307BDC.8060602@trash.net>
Date: Tue, 20 Sep 2005 23:15:08 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
CC: lkml <linux-kernel@vger.kernel.org>, netfilter-devel@lists.netfilter.org
Subject: Re: Intermittent NAT failure when multiple hosts send UDP packets
References: <432B8702.3060801@develer.com> <432CD386.201@develer.com> <43306484.2060103@develer.com>
In-Reply-To: <43306484.2060103@develer.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> I'm sorry to say that this bug has shown up again on
> 2.6.13 too, so it's not fixed at all.
> 
> It's quite hard to trigger, but after it does, packets
> are consistently routed with the source IP untranslated.

Please try "echo 255 >
/proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid"
and modprobe ipt_LOG to see if conntrack ignores them because
of invalid checksums or something.
