Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWANWHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWANWHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWANWHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:07:15 -0500
Received: from mail.dvmed.net ([216.237.124.58]:56718 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751316AbWANWHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:07:13 -0500
Message-ID: <43C97605.9030907@pobox.com>
Date: Sat, 14 Jan 2006 17:07:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuffed Crust <pizza@shaftnet.org>
CC: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org>
In-Reply-To: <20060114011726.GA19950@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Stuffed Crust wrote: > The hardware knows what
	frequencies it supports. Unfortunately this has > to be a somewhat
	dynamic thing, as this is often not queryable until the > device
	firmware is up and running. > > This can be accomplished by passing a
	static table to the > register_wiphy_device() call (or perhaps via a
	struct wiphy_dev > parameter) or through a more explicit, dynamic
	interface like: > > wiphy_register_supported_frequency(hw, 2412). [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuffed Crust wrote:
> The hardware knows what frequencies it supports.  Unfortunately this has 
> to be a somewhat dynamic thing, as this is often not queryable until the 
> device firmware is up and running.  
> 
> This can be accomplished by passing a static table to the 
> register_wiphy_device() call (or perhaps via a struct wiphy_dev 
> parameter) or through a more explicit, dynamic interface like:
> 
>   wiphy_register_supported_frequency(hw, 2412). 


For completely programmable hardware, the stack should interact with a 
module like ieee80211_geo, to help ensure the hardware stays within 
legal limits.

	Jeff


