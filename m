Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSDIT0u>; Tue, 9 Apr 2002 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSDIT0t>; Tue, 9 Apr 2002 15:26:49 -0400
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:58541 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S310979AbSDIT0s>; Tue, 9 Apr 2002 15:26:48 -0400
Date: Tue, 9 Apr 2002 12:26:45 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200204091926.g39JQjZ09056@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 data corruption issues
Cc: rmiller@duskglow.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a very similar setup and I ran 2.4.18 for about a month with similar
corruptions. Things seem better with 2.4.19pre6. I wrote some test programs
to copy and compare files on 5 drives at once as well as a large footprint
program that checksums an array the size of RAM and then sleeps to let it 
page out and then repeats, to beat up on swap. No failures on 2.4.19pre6 except
I did hit the infamous 3ware 7810 Tyan 2460 lockup and had to remove the 3ware
array from my test.

>I am running the stock 2.4.18 kernel, downloaded a few days ago from the 
>kernel mailing list.  The kernel was custom-built to my specifications, using 
>the default RH7.2 gcc (config available upon request).  The machine is a dual 
>pentium-III 1000 MHz, one scsi drive (sym53cxxx criver) and two ide drives.  
>All filesystems are ext3 journaling.
>
>We copied several very large partitions from one machine to another in an 
>attempt to put a new machine in service.  Just for kicks, we attempted to 
>verify the copy.  It turns out that a small amount of files, about 60 to 100 
>on a 17 gig partition, are corrupted.  Mod times are exactly the same, 
>owners, even file size.  It turns out that pretty consistently four null 
>characters (and occasionally other characters and a different number) are 
>appended to the beginning of the file, and the last four characters are 
>rolled off the end.  We ran the copy (and rsync and stuff) multiple times.  
>Each time different files were modified, in a seemingly random fashion, but 
>with a fairly consistent pattern of corruption.
>
