Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310389AbSCLEOB>; Mon, 11 Mar 2002 23:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310391AbSCLENv>; Mon, 11 Mar 2002 23:13:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51982 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310389AbSCLENk>;
	Mon, 11 Mar 2002 23:13:40 -0500
Message-ID: <3C8D8061.4030503@mandrakesoft.com>
Date: Mon, 11 Mar 2002 23:13:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111829550.1153-100000@home.transmeta.com> <3C8D69E3.3080908@mandrakesoft.com> <20020311223439.A2434@zalem.nrockv01.md.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:

>On Mon, Mar 11, 2002 at 09:37:23PM -0500, Jeff Garzik wrote:
>
>>It serves to encourage openness, nobody is forced to use it, and it 
>>provides an additional layer of protection for those that choose to use 
>>it.  That is the point.
>>
>
>It doesn't provide any meaningful protection, that's the point.
>
>If you're root/have CAP_SYS_RAWIO, you can bit-bang the interface, you
>can patch out the filter from the kernel binary, you can do whatever
>pleases you.  Don't run evil programs as root in the first place.  And
>if you want to have finer-grained capabilities for specific
>drive-level actions, create an higher-level interface for them which
>will guarantee that only safe commands are used because they will be 
>

Under more restricted domains, root cannot bit-bang the interface. 
 s/CAP_SYS_RAWIO/CAP_DEVICE_CMD/ for the raw cmd ioctl interface.  Have 
the OS trap I/O port accesses using SMM mode if you would like, and that 
applies to your particular security situation.

The filter is useful for other reasons like correctness, as well.

    Jeff




