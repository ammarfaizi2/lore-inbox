Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUADR7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbUADR7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:59:10 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:55976
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S265740AbUADR7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:59:06 -0500
Message-ID: <3FF8558A.2080308@reactivated.net>
Date: Sun, 04 Jan 2004 18:03:54 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herve Fache <herve.fache@europemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hangs on nVidia nForce2 400 Ultra
References: <20040104173624.19046.qmail@iname.com>
In-Reply-To: <20040104173624.19046.qmail@iname.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Theres been some work done on this issue lately. Originally, my system only 
hung when I had IO-APIC and local APIC support compiled into the kernel. But I 
think other people had hanging problems even without this.

You could first try using a 2.6-mm series kernel, as these include some 
patches which fix nforce2 problems for most people (but not me).

The other option is to try Ross Dickinson's patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107199838022614&w=2

If you use Ross's patches, as well as the -mm fixes, you should revert out the 
nforce-disconnect-quirk patch to avoid your CPU getting needlessly hot.

Personally, I have stability running 2.6.1-rc1-mm1 with the disconnect-quirk 
reverted out, Ross's patches, booting with parameter apic_tack=2. I have 
APIC/IOAPIC compiled in and working.

Daniel.

Herve Fache wrote:
> Hi chaps!  
>   
> My system hangs (no oops, nothing) on disk access using either 2.4.23 or 2.6.0. A rather reliable way for me to  
> crash it is to, for example, copy the sources of the Linux kernel.  
>   
> It hanged once on CD-ROM access, which could lead to a more IDE-level problem. Also, the only time it did it in  
> another operating system (humm...) was after it crashed in Linux and I pressed reset (no shut down), which  
> makes me think it could the IDE controller [driver]'s fault...  
>   
> It seems I'm the only one on Earth to have this problem (according to Google), but if there was a way to track it 
> down I'd be happy to try.  
>   
> I have attached my 2.6.0 kernel config for info.  
>   
> Thanks!  
> Hervé.  
