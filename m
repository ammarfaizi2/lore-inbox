Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVAaUax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVAaUax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVAaUax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:30:53 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:47240 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261330AbVAaUag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:30:36 -0500
Date: Mon, 31 Jan 2005 21:29:42 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bukie Mabayoje <bukiemab@gte.net>, sfeldma@pobox.com,
       Michael Gernoth <simigern@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
Message-ID: <20050131202940.GA26992@hardeman.nu>
References: <20050130171849.GA3354@hardeman.nu> <1107143255.18167.428.camel@localhost.localdomain> <41FDB2D3.5CBD6F7D@gte.net> <20050131152431.GA14176@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20050131152431.GA14176@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 01:24:31PM -0200, Marcelo Tosatti wrote:
>On Sun, Jan 30, 2005 at 08:23:47PM -0800, Bukie Mabayoje wrote:
>> Scott Feldman wrote:
>>> David, would you give this patch a try?  Make sure the system still
>>> wakes from a magic packet if suspended or shut down, and doesn't cause
>>> kacpid to go crazy if system is running.  If it helps for 2.6, perhaps
>>> someone can look into 2.4 to see if there is something similar going on
>> 
>> This issue was reported on 2.4.
>
>Can any of you guys test v2.6, please?
>

I tried the second patch provided by Scott on a 2.6.10 kernel, I did 
some minor tweaks to get it to apply (changed pci_choose_state() and 
PCI_D0 back to the way they were in 2.6.10) and tested the results five 
minutes ago.

It works great, I havent tried suspending the machine cause I have no 
need for that functionality. I have however started the machine via WOL 
(works), sent WOL-packet to the machine when powered on (nothing 
happends - kacpid doesn't go wild, works), shutdown (works without the 
machine spontaneously rebooting). 

So everything seems to be fixed by the patch (save for suspending which 
I didn't test).

Thanks alot, I hope the patch will be in the next stable 2.6 kernel.

Regards,
David

