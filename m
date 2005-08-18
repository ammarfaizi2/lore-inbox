Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVHRRe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVHRRe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVHRRe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:34:57 -0400
Received: from main.gmane.org ([80.91.229.2]:10444 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932329AbVHRRe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:34:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: overflows in /proc/net/dev
Date: Thu, 18 Aug 2005 19:30:46 +0200
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <de2gk6$nb6$1@sea.gmane.org>
References: <1124350090.29902.8.camel@basti79.freenet-ag.de> <20050818163358.GA19554@taniwha.stupidest.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54b89e9a.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Aug 18, 2005 at 09:28:10AM +0200, Sebastian Cla?en wrote:
>> in struct net_device_stats all members are defined as unsgined
>> long. In time of gigabit ethernet this takes not long to overflow.
> It should still take an appreciable amount of time surely?  We can

With 100MBit it took about 5 minutes to overflow the 32bit byte counters
(too less for typical mrtg and Nyquist-Shannon sampling theorem in
mind), with 1GBit it takes about 30 seconds.
If you consider this appreciable... well :)

> detect those wraps in userspace and deal with it as needed.

Of course, it's usually enough time for a typical userspace application
to get scheduled at least twice.


regards
   Mario
-- 
User sind wie ideale Gase - sie verteilen sich gleichmaessig ueber alle Platten

