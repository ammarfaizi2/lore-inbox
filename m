Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317982AbSGLEPO>; Fri, 12 Jul 2002 00:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317983AbSGLEPN>; Fri, 12 Jul 2002 00:15:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4618 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317982AbSGLEPM>; Fri, 12 Jul 2002 00:15:12 -0400
Message-ID: <3D2E585F.2010302@zytor.com>
Date: Thu, 11 Jul 2002 21:17:35 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <agl7ov$p91$1@cesium.transmeta.com> <20020712041320.GA2046@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Thu Jul 11, 2002 at 05:27:11PM -0700, H. Peter Anvin wrote:
> 
>>Okay, I have suggested this before, and I haven't quite looked at this
>>in detail, but I would again like to consider the following,
>>especially given the changes in 2.5:
>>
>>Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
>>and treat all ATAPI devices as what they really are -- SCSI over IDE.
>>It is a source of no ending confusion that a Linux system will not
>>write CDs to an IDE CD-writer out of the box, for the simple reason
>>that cdrecord needs access to the generic packet interface, which is
>>only available in the nonstandard ide-scsi configuration.
> 
> 
> cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
> work regardless,
> 

Lovely.  Let's make EACH APPLICATION support two disjoint APIs for no 
good reason.

Got any other brilliant ideas?

	-hpa


