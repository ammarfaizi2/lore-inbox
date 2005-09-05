Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVIEXHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVIEXHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVIEXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:07:22 -0400
Received: from smtpout.mac.com ([17.250.248.83]:971 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964924AbVIEXHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:07:22 -0400
In-Reply-To: <x3ky86b5enz.fsf@Psilocybe.Update.UU.SE>
References: <4IcUz-7H2-27@gated-at.bofh.it> <4J2gx-3zf-3@gated-at.bofh.it> <4J5R1-cH-21@gated-at.bofh.it> <4J6ao-L9-21@gated-at.bofh.it> <4J6jZ-Xg-11@gated-at.bofh.it> <4J8vt-43Y-13@gated-at.bofh.it> <x3ky86b5enz.fsf@Psilocybe.Update.UU.SE>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E6A1734-A6B6-4189-9656-C252D677BB32@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Mon, 5 Sep 2005 19:06:58 -0400
To: Thorild Selen <thorild@Update.UU.SE>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 5, 2005, at 18:32:32, Thorild Selen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
>> Please name situations where 8K stacks may be preferred that do not
>> involve binary-only modules.
>
> How about NFS-exporting a filesystem on LVM atop md?  I believe it has
> been mentioned before in discussions that 8k stacks are strongly
> recommended in this case.  Are those issues solved?

I think the worst overflow case anyone found was  
nfs=>xfs=>lvm=>dm=>scsi, if
someone has such a configuration, please retest with current -mm or  
similar.
I think there are several patches in there to resolve the excessive  
stack
usage and a few to do some sort of bio chaining (Instead of recursive  
calls).
I don't remember what underlying hardware was behind the SCSI, but I  
suspect
something like iSCSI or USB would push some extra stack in there for  
stress
testing.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at
it in the right way, did not become still more complicated.
   -- Poul Anderson



