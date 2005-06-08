Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVFHRNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFHRNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVFHRNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:13:02 -0400
Received: from fmr20.intel.com ([134.134.136.19]:28069 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261428AbVFHRLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:11:42 -0400
Message-ID: <42A7268D.9020402@linux.intel.com>
Date: Wed, 08 Jun 2005 12:10:37 -0500
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050519
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
References: <20050608142310.GA2339@elf.ucw.cz> <200506081744.20687.vda@ilport.com.ua>
In-Reply-To: <200506081744.20687.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>My position is that wifi drivers must start up in an "OFF" mode.
>Do not send anything. Do not join APs or start IBSS.
>Thus, no need to load fw in early boot.
>  
>
This should be an option for the user if that is the desired behavior. 
We support that with the ipw2100 and ipw2200 projects via module
parameters to disable the radio during module load.  Having a standard
module parameter for wireless drivers would be nice.

My approach is to make the driver so it supports as many usage models as
possible, leaving policy to other components of the system.  If the user
wants it to scan and associate immediately, that should be supported. 
Likewise if they want the module to be loaded w/ the radio off, they can
do that as well.

Since most (if not all) laptops support an RF kill switch, I tend to
defer to the physical switch as the user's point of control and set the
driver defaults to try and use the radio if it is enabled.

James

