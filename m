Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUEDAzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUEDAzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUEDAzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:55:37 -0400
Received: from ns.clanhk.org ([69.93.101.154]:62624 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S264170AbUEDAza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:55:30 -0400
Message-ID: <4096EA32.10201@clanhk.org>
Date: Mon, 03 May 2004 19:56:18 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting off of IDE while using different libata drives on same
 southbridge
References: <200403121826.21442.markus.kossmann@inka.de> <200403121902.44371.bzolnier@elka.pw.edu.pl> <4096B752.9050602@clanhk.org> <200405032344.58597.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405032344.58597.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>On Monday 03 of May 2004 23:19, J. Ryan Earl wrote:
>  
>
>>I am having a similar problem to what Markus Kossmann wrote about, but
>>with the VIA Southbridge (Asus K8V).  My situation is similar, but a
>>little different.  I would like to boot off a PATA drive attached to the
>>Southbridge, but use libata for a couple SATA drives attached to the
>>same Southbridge.
>>
>>Is this still not possible?  I also tried hde/hdg=noprobe options, but
>>they didn't help the situation.  It appears the only way to get the
>>drives on sata_via is to boot off of them.  Am I correct in thinking
>>this is the only way to go about this?
>>    
>>
>
>Did you actually tried it (booting off of them)?
>[ I can't see how this can help. ]
>  
>
With libata linked into the kernel, and ide as a module, I can boot off 
of libata.

>Just don't compile-in generic IDE PCI driver which controls your SATA drives
>(or don't load this module if you're using initrd).
>  
>
As I said, I want to boot off of the PATA drives attached to the 
southbridge.  To boot of them, I have to have the IDE driver compiled 
into the kernel; if I do this I can't use libata on that southbridge, 
the IDE driver take precedence for the serial ata channels.

-ryan
