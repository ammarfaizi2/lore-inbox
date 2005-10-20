Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVJTWQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVJTWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVJTWQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:16:56 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:53817 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932544AbVJTWQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:16:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZKBB3lPUdnYSXGvuzg3VpTqtViOBioARM+B2mYUnPmAE5v+uhzEUlJbF9G1xBWOGeKmVNZQzRHRA9MzCqo3r3Am464KyESOREX1kiQz9t8GQA6paBjcbuyFccj3G86V8hCDOuTDPRfyM/COzsp8W6sQNyKYNwzPPnjSY+IWNNLA=
Message-ID: <4358173B.20509@gmail.com>
Date: Fri, 21 Oct 2005 08:16:27 +1000
From: Grant Coady <gcoady@gmail.com>
Organization: http://bugsplatter.mine.nu/
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.4: 'find' complained about sysfs
References: <4357E4E9.4@t-online.de>
In-Reply-To: <4357E4E9.4@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Hi folks,
> 
> When I ran 'find /sys -name modalias' I got an error
> message on stderr saying
> 
> find: WARNING: Hard link count is wrong for /sys/devices: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched.
> 
> uname -a:
> Linux pluto 2.6.13.4 #1 Sun Oct 16 22:41:26 CEST 2005 x86_64 GNU/Linux
> 
grant@sempro:~$ find /sys -name modalias
/sys/devices/pci0000:00/0000:00:11.5/modalias
/sys/devices/pci0000:00/0000:00:11.0/modalias
/sys/devices/pci0000:00/0000:00:10.4/usb1/1-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:10.4/modalias
/sys/devices/pci0000:00/0000:00:10.2/usb3/3-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:10.2/modalias
/sys/devices/pci0000:00/0000:00:10.0/usb2/2-1/2-1:1.0/modalias
/sys/devices/pci0000:00/0000:00:10.0/usb2/2-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:10.0/modalias
/sys/devices/pci0000:00/0000:00:0f.1/modalias
/sys/devices/pci0000:00/0000:00:0f.0/modalias
/sys/devices/pci0000:00/0000:00:07.0/modalias
/sys/devices/pci0000:00/0000:00:06.0/modalias
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/modalias
/sys/devices/pci0000:00/0000:00:01.0/modalias
/sys/devices/pci0000:00/0000:00:00.0/modalias
/sys/devices/platform/i8042/serio1/modalias
/sys/devices/platform/i8042/serio0/modalias
grant@sempro:~$ uname -r
2.6.13.4a

and another:

grant@tosh:~$ find /sys -name modalias
/sys/devices/pci0000:00/0000:00:0c.0/modalias
/sys/devices/pci0000:00/0000:00:0b.0/0000:02:00.0/modalias
/sys/devices/pci0000:00/0000:00:0b.0/modalias
/sys/devices/pci0000:00/0000:00:07.0/modalias
/sys/devices/pci0000:00/0000:00:05.3/modalias
/sys/devices/pci0000:00/0000:00:05.2/usb1/1-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:05.2/modalias
/sys/devices/pci0000:00/0000:00:05.1/modalias
/sys/devices/pci0000:00/0000:00:05.0/modalias
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/modalias
/sys/devices/pci0000:00/0000:00:01.0/modalias
/sys/devices/pci0000:00/0000:00:00.0/modalias
/sys/devices/platform/i8042/serio1/modalias
/sys/devices/platform/i8042/serio0/modalias
grant@tosh:~$ uname -r
2.6.13.4a

Sorry no clue from me :(
Grant.
