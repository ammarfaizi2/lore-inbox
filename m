Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVEKO0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVEKO0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEKO0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:26:35 -0400
Received: from main.gmane.org ([80.91.229.2]:53889 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261225AbVEKO0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:26:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: statfs returns wrong values for 250Gb FAT fs
Date: Wed, 11 May 2005 15:23:36 +0300
Message-ID: <pan.2005.05.11.12.23.33.926661@yahoo.com>
References: <E1DUT2T-0000fm-Nx@localhost.localdomain> <20050510080907.GR1998@verge.net.au> <87oebjxpcc.fsf@devron.myhome.or.jp> <42811AE6.7020902@mail.telepac.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217.96.20.115
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 May 2005 21:34:46 +0100, Carlos Rodrigues wrote:

> OGAWA Hirofumi wrote:
> 
>>Filesystem may have the corrupted free-cluster value.
>>
>>I couldn't reproduce the problem on 2.6.12-rc4.
>>
>>Could you try a recently dosfsck (dosfstools-2.11 or later)? Also could
>>you send the output of above program?
>>  
>>  
>>
> "dosfsck" did find a problem in the free-cluster value. And also said the
> backups FAT was different than the original FAT.
> 
> I didn't use "dosfsck" to fix the problems though (not that it couldn't, I
> just didn't try). As I had already copied everything to another disk, I
> just used "mkdosfs" to reformat the drive, and it works just fine now.
> 
> I still don't know what caused this, probably something related to some
> "kernel panics" I was seeing on shutdown (in a Fedora 3 installation, not
> Debian), after doing an umount+unplug.
> 
> I didn't though of using "dosfsck" because Windows' checkdisk was saying
> the filesystem was perfectly fine... It makes me feel really safe trusting
> MS tools... not.
> 
> Carlos Rodrigues

I had the same problem with an external 250 GB vfat USB 2.0 disk.
The disk was formatted/used previously in windows, checkdisk said is OK,
but mounted in linux readonly, game the same error (said only some little
space was free, when in fact it was almost full).
However, I was able to see and copy all files from it.
As it was not my hard disk, I did not reformatted it, nor dosfsck-ed it.
DOSFSCK reported errors with the FAT copy, and other errors, but as I
said, I could access all data on it.

Best regards,
Paul


