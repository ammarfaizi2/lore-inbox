Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284807AbRLHUi3>; Sat, 8 Dec 2001 15:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284805AbRLHUiU>; Sat, 8 Dec 2001 15:38:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9225 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284807AbRLHUiF>; Sat, 8 Dec 2001 15:38:05 -0500
Message-ID: <3C127A1C.2040706@zytor.com>
Date: Sat, 08 Dec 2001 12:37:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: On re-working the major/minor system
In-Reply-To: <E16CfsW-0001AL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>That works, and should prevent most major problems.  Hmm.  At
>>>least for cpio there are 6 chars worth of device info in there,
>>>so we coule easily go to 48 bits without RPM problems.  Or redhat
>>>could fix rpm to use tarballs like debs do, and then we could go
>>>
> 
> RPM can't easily use tarballs. Too much of a tar ball isnt rigidly defined so
> you can cryptographically sign it.
> 


Why does that matter?  You're signing a *specific instance* of tar, not 
the generic format.


> 
>>>to 64 bit devices no problem.
>>>
>>The big stubling block seems to be NFSv2.
> 
> Well 2.5 isnt going to be able to support NFS without a magic daemon
> maintained translation table - so that when the kernel randomly changes the
> major/minor number of an exported file system (eg a USB reconnect or even plain
> boring shutdown/reboot) it can keep consistent file handles.
> 
> If you have a file handle table surely you can remap every NFS file handle
> through that down to 32bits. For device files the problem doesn't matter 
> because at the kernel meeting Linus said those were going to change in a way
> that meant devices over NFS are a lost cause and clients would have to use
> devfs
> 


Yeah, I know what Linus said at the kernel summit.  As far as I could 
tell he rejected anything that seemed like a sensible approach from here 
to there, but that's just my $0.02...

	-hpa


