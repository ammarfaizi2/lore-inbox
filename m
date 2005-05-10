Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVEJUmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVEJUmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVEJUlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:41:52 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:54235 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S261775AbVEJUey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:34:54 -0400
X-AntiVirus: PTMail-AV 0.3.83
Message-ID: <42811AE6.7020902@mail.telepac.pt>
Date: Tue, 10 May 2005 21:34:46 +0100
From: Carlos Rodrigues <carlos.efr@mail.telepac.pt>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Horms <horms@debian.org>, 308072@bugs.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: statfs returns wrong values for 250Gb FAT fs
References: <E1DUT2T-0000fm-Nx@localhost.localdomain>	<20050510080907.GR1998@verge.net.au> <87oebjxpcc.fsf@devron.myhome.or.jp>
In-Reply-To: <87oebjxpcc.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:

>Filesystem may have the corrupted free-cluster value.
>
>I couldn't reproduce the problem on 2.6.12-rc4.
>
>Could you try a recently dosfsck (dosfstools-2.11 or later)?
>Also could you send the output of above program?
>  
>

"dosfsck" did find a problem in the free-cluster value. And also said 
the backups FAT was different than the original FAT.

I didn't use "dosfsck" to fix the problems though (not that it couldn't, 
I just didn't try). As I had already copied everything to another disk, 
I just used "mkdosfs" to reformat the drive, and it works just fine now.

I still don't know what caused this, probably something related to some 
"kernel panics" I was seeing on shutdown (in a Fedora 3 installation, 
not Debian), after doing an umount+unplug.

I didn't though of using "dosfsck" because Windows' checkdisk was saying 
the filesystem was perfectly fine... It makes me feel really safe 
trusting MS tools... not.

Carlos Rodrigues

