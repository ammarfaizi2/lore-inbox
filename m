Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWCaRtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWCaRtN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWCaRtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:49:12 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:7611 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932152AbWCaRtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:49:06 -0500
Message-ID: <442D7790.2010300@wolfmountaingroup.com>
Date: Fri, 31 Mar 2006 11:40:16 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
 reset.
References: <20060330213928.GQ2172@austin.ibm.com> <20060331000208.GS2172@austin.ibm.com> <442C8069.507@wolfmountaingroup.com> <20060331003506.GU2172@austin.ibm.com> <442CACC0.1060308@wolfmountaingroup.com> <20060331170319.GV2172@austin.ibm.com>
In-Reply-To: <20060331170319.GV2172@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:

>On Thu, Mar 30, 2006 at 09:14:56PM -0700, Jeffrey V. Merkey wrote:
>  
>
>>Yes, we need one. The adapter needs to maintain these stats from the
>>registers in the kernel structure and not
>>its own local variables. 
>>    
>>
>
>Did you read the code to see what the adapter does with these stats? 
>Among other things, it uses them to adaptively modulate transmit rates 
>to avoid collisions. Just clearing the hardware-private stats will mess
>up that function.
>
>  
>
I noticed that.

>>That way, when someone calls to clear the stats
>>for testing and analysis purposes,
>>they zero out and are reset.
>>    
>>
>
>1) ifdown/ifup is guarenteed to to clear things. Try that.
>  
>
No, not dynamic. I'll patch the driver locally, thanks.

Jeff

>2) What's wrong with taking deltas? Typical through-put performance
>measurement is done by pre-loading the pipes (i.e. running for
>a few minutes wihtout measuring, then starting the measurement).
>I'd think that snapshotting the numbers would be easier, and is 
>trivially doable in user-space. I guess I don't understand why 
>you need a new kernel featre to imlement this.
>
>--linas
>
>  
>

