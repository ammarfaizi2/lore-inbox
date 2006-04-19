Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWDSRFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWDSRFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWDSRFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:05:51 -0400
Received: from emulex.emulex.com ([138.239.112.1]:27621 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1750967AbWDSRFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:05:50 -0400
Message-ID: <44466DE1.4080409@emulex.com>
Date: Wed, 19 Apr 2006 13:05:37 -0400
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain>	<20060418160121.GA2707@us.ibm.com>	<444633B5.5030208@emulex.com> <20060419092645.29cb0420@localhost.localdomain>
In-Reply-To: <20060419092645.29cb0420@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2006 17:05:37.0676 (UTC) FILETIME=[7AD66CC0:01C663D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Hemminger wrote:
> On Wed, 19 Apr 2006 08:57:25 -0400
> James Smart <James.Smart@Emulex.Com> wrote:
> 
>> Folks,
>>
>> To take netlink to where we want to use it within the SCSI subsystem (as
>> the mechanism of choice to replace ioctls), we're going to need to pass
>> user-space buffer pointers.
> 
> This changes the design of netlink. It is desired that netlink
> can be done remotely over the network as well as queueing.
> The current design is message based, not RPC based. By including a
> user-space pointer, you are making the message dependent on the
> context as it is process.
> 
> Please rethink your design.

I assume that the message receiver has some way to determine where the
message originated (via the sk_buff), and thus could reject it if it
didn't meet the right criteria.  True ?  You just have to be cognizant
that it is usable from a remote entity - which is a very good thing.
