Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWBRQBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWBRQBB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWBRQAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21420 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751451AbWBRQAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:34 -0500
Date: Sat, 18 Feb 2006 16:58:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 5/5] [pci pm] Make pci_choose_state() use the real device state requested
Message-ID: <20060218155836.GF5658@openzaurus.ucw.cz>
References: <Pine.LNX.4.50.0602171759190.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602171759190.30811-100000@monsoon.he.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  	case PM_EVENT_FREEZE:
>  	case PM_EVENT_SUSPEND:
> -		return PCI_D3hot;
> +		if (msg.state && msg.state <= PCI_D3hot)
> +			state = msg.state;
> +		break;
>  	default:

Silently ignores wrong value passed-in by user. Not nice...
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

