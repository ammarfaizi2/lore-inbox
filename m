Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWBBPZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWBBPZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWBBPZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:25:05 -0500
Received: from smtpout.mac.com ([17.250.248.87]:55776 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932077AbWBBPZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:25:01 -0500
X-PGP-Universal: processed;
	by AlPB on Thu, 02 Feb 2006 09:24:28 -0600
In-Reply-To: <43E1B490.7080200@pobox.com>
References: <200602010609.k1169QDX017012@hera.kernel.org> <43E0F73B.6040507@pobox.com> <A9543B03-333E-470F-AD18-0313192ADB23@mac.com> <1138857560.15691.0.camel@mindpipe> <D1A90FC1-95F7-4C2B-BC6D-1F60000FC989@mac.com> <43E1B490.7080200@pobox.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CBCD4CAD-57C8-41A6-9265-83834064EADC@mac.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [PATCH] PCI: restore 2 missing pci ids
Date: Thu, 2 Feb 2006 09:24:09 -0600
To: Jeff Garzik <jgarzik@pobox.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 2, 2006, at 1:28 AM, Jeff Garzik wrote:

> Kyle Moffett wrote:
>> On Feb 02, 2006, at 00:19, Lee Revell wrote:
>>> On Wed, 2006-02-01 at 23:11 -0600, Mark Rustad wrote:
>>>
>>>> Why were the ids removed in the first place?
>>>
>>> Because they weren't used by anything in the tree.
>> Also, the new PCI-ID policy is to put the defines in the driver   
>> itself, near where it is used, instead of collecting them in a  
>> single  file.  The goal is to minimize the number of unused PCI  
>> IDs in the  tree by keeping the definition near the usage.
>
> No, if you do create a constant for a PCI ID, it still should go  
> into include/linux/pci_ids.h.
>
> Putting them in the driver will result in highly variable naming  
> policies, which in turn means the constants are less grep-able than  
> today.
>
> Device IDs simply do not need an associated constant, if they are  
> used only in a PCI ID table.  Device IDs are arbitrary numbers that  
> are normally only used once in a source file.
>
> Vendor IDs are used repeatedly, and definitely belong in pci_ids.h.  
> Device IDs make sense in pci_ids.h if they are used more than once.

Thank you for explaining the policy. In this particular case, there  
was only one use of the ID in the file in question, so it could have  
simply been a hex constant, I guess. Of course my instinct is to  
avoid weird constants like this in source code, but I can learn to  
make an exception for this kind of thing.

-- 
Mark Rustad, MRustad@mac.com

