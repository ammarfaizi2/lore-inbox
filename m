Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVASQDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVASQDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVASQDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:03:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:44278 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261762AbVASQDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:03:19 -0500
Message-ID: <41EE8416.502@austin.ibm.com>
Date: Wed, 19 Jan 2005 10:00:22 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
Reply-To: nfont@austin.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org,
       linuxppc64-dev@ozlabs.org, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: EEH Recovery
References: <20050106192413.GK22274@austin.ibm.com>	<20050117201415.GA11505@austin.ibm.com> <16877.63693.915740.385920@cargo.ozlabs.ibm.com>
In-Reply-To: <16877.63693.915740.385920@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Mackerras wrote:

> 5. AFAICS userland will get an unplug notification for the device, but
>    nothing to indicate that is due to an EEH slot isolation event.  I
>    think userland should be told about EEH events.
> 

Currently there is a way for userland to determine if a hotplug event 
they receive is due to an EEH slot isolation event.  It's not very 
pretty and requires the rtas_errd daemon to be running.

The RTAS event generated from the EEH event is logged to 
/var/log/platform by rtas_errd.  Userland scripts would have to search 
the file for a recent EEH event matching their device to make this 
determination.  This isn't as nice as a direct notification but is what 
we have at this point.

-- 
Nathan Fontenot
