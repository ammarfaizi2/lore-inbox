Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293441AbSCFJqr>; Wed, 6 Mar 2002 04:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCFJq1>; Wed, 6 Mar 2002 04:46:27 -0500
Received: from [195.63.194.11] ([195.63.194.11]:57861 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292986AbSCFJqP>; Wed, 6 Mar 2002 04:46:15 -0500
Message-ID: <3C85E524.6000101@evision-ventures.com>
Date: Wed, 06 Mar 2002 10:45:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16iPv4-00052k-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Note that taskfiles are not being removed from IDE. Just direct (and
>>parsed and filtered) interface to userspace. Does the scsi midlayer
>>export the SCBs directly to userspace?
>>
> 
> Yes. And whats more the scsi generic layer has a hell of a lot less ioctls
> than IDE because of that. With something like scsi enclosure, scsi smart,
> scsi scanners its a godsend to be able to just say "Ok OS take a hike, I
> wish to chat with this device exactly as I damn well please".

Please note that the plenthora of IDE ioctl comes from the fact that the
ioctl interface is trying to export every single possible IDE command
as an specific ioctl. This mechanism just got even extendid and called
"taskfile".

