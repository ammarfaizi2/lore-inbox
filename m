Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751944AbWISMGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbWISMGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 08:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWISMGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 08:06:07 -0400
Received: from main.gmane.org ([80.91.229.2]:44193 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751944AbWISMGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 08:06:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: TCP stack behaviour question
Date: 19 Sep 2006 14:03:30 +0200
Message-ID: <87wt802hd9.fsf@willow.rfc1149.net>
References: <005a01c6db50$587929c0$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stuart" == Stuart MacDonald <stuartm@connecttech.com> writes:

Stuart> I suppose that the TCP retransmits aren't being sent because
Stuart> the ethernet and/or IP layers don't know what's going on,
Stuart> which is what's producing the arps. Is that correct?

It seems correct. You cannot expect TCP packets to be sent if the
target is supposedly on a directly connected network and ARP cannot
get its MAC address. What should the IP layer put as the MAC address
if it is unknown?

You may want to run another test with another unreachable target
located after a router, so that the MAC address of the router is used
on the wire. You should see all the TCP retransmits you expect to see.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

