Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUHIKuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUHIKuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUHIKuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:50:09 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:22542 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266473AbUHIKtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:49:39 -0400
Message-ID: <41175798.7000406@hist.no>
Date: Mon, 09 Aug 2004 12:53:12 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
In-Reply-To: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

>>From: Martin Mares <mj@ucw.cz>
>>    
>>
>
>  
>
>>>It seems that you are not really interested to understand how it works :-(
>>>      
>>>
>
>  
>
>>I am interested, but I life is too short to read the full docs of all existing
>>OS's. Can you give me at least a pointer to the relevant section?
>>    
>>
>
>I already did! ---> "man path_to_inst"
>
>  
>
>>>If you behave this way, I tend to believe that you have a precasted opinion 
>>>that you are not willing to change.
>>>      
>>>
>
>  
>
>>I think that most people around there tend to believe exactly the same about you :-)
>>But let's change that.
>>    
>>
>
>I _am_ always open to new experiences but the problem with most if not all
>of the people in LKML is that they only know things about Linux while I know 
>many different operating systems.
>
>  
>
>>Most of all, I would like to know (I see I'm repeating myself, but I still
>>haven't seen an answer to that) what's so special about the SCSI-like devices,
>>that they would have to be addressed in a completely different way from the
>>other UNIX devices. For the classical SCSI, you might argue that addressing
>>by the physical topology is more realistic, but for ATAPI or USB disks,
>>the SCSI triplets have nothing to do with the physical topology.
>>    
>>
>
>I did introduce Generic SCSI in August 1986. The interface used by libscg today 
>is exactly the same interface as it has been used in August 1986.
>
>The problem with Linux is that the "interfaces" constantly change.
>Let us talk again in October 2018 (then the /dev/hd* Interface on Linux
>would have the same age as my libscg has now) and check what happened to this
>interface. If the interface did not change and is still binary compatible, you 
>_may_ be right. However this is most improbable.
>
>>From the > 20 platforms that libscg provides abstractions from, _most_
>platforms do not allow the "UNIX" /dev/something method to work with
>Generic SCSI:
>
>-	DOS
>
>-	Win9x
>
>-	WinNT
>
>-	VMS
>
>-	MacOS X
>
>-	AmigaOS
>
>-	Apollo DomainOS
>
>-	BeOS (uses CAM)
>
>-	FreeBSD (uses CAM)
>
>-	Next Step (Generic SCSI only works only with a special /dev/sg%d)
>
>-	OS/2
>
>-	OSF-1 / True-64 (uses CAM)
>
>-	QNX (uses CAM)
>
>-	SunOS-4.x
>
>-	Linux (all older versions)
>
>-	SCO OpenServer
>
>-	SCO UnixWare
>
>These are the platforms where /dev/something could work:
>
>-	Linux-2.6 
>
>-	AIX
>
>-	BSD-OS
>
>-	OpenBSD
>
>-	HP-UX
>
>-	SGI IRIX
>
>-	Solaris (newer versions only)
>
>As you see, the vast majority does not allow the adressing method the
>people on LKML seem to prefer recently.
>  
>
People with different os'es prefer different adressing schemes.  It is
that simple, they don't want to use the scheme used in another os. Not
even if you think it is better somehow.  Most people don't want to deal 
with many os'es.

If you want to provide a multi-platform app with an acceptable user 
interface, then
you have to cope with the different adressing schemes.  If that is too much
work, consider taking patches from volunteers similiar to how the linux 
kernel
and many other big projects are managed.  I am sure you can get someone to
write "perfect" support for /dev/XYZ on linux for you, if you're willing 
to apply
such a patch.  And similiar for other os'es that diverge from your own 
preferred way.

Helge Hafting


