Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUDBCTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUDBCTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:19:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:44686 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263126AbUDBCT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:19:29 -0500
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <20040401214031.GA22366@suse.de>
References: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li> <1080687527.1198.48.camel@gaston> <20040401214031.GA22366@suse.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EB25E80C-8454-11D8-9D9B-0003931E0B62@gmx.li>
Content-Transfer-Encoding: 7bit
From: Martin Schaffner <schaffner@gmx.li>
Subject: Re: booting 2.6.4 from OpenFirmware
Date: Fri, 2 Apr 2004 04:22:06 +0100
To: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.2004, at 16:17, Tom Rini wrote:

> On Thu, Apr 01, 2004 at 02:17:24AM +0100, Martin Schaffner wrote:
>>
>> On 30.03.2004, at 23:58, Benjamin Herrenschmidt wrote:
>>
>>> On Wed, 2004-03-31 at 08:18, Martin Schaffner wrote:
>>>> Hi,
>>>>
>>>> I try to boot linux-2.6.4 from OpenFirmware on my Apple iBook2 (dual
>>>> USB). I'm using the image named "vmlinux.elf-pmac". While 
>>>> linux-2.4.25
>>>> boots fine, linux-2.6.4 doesn't  [...]
>>>>
>>>> If I try to boot the stock kernel, OpenFirmware tells me "Claim
>>>> failed", and returns to the command prompt.
>>>
>>> That's strange, I do such netbooting everyday on a wide range of
>>> machines without trouble. Are you using some kind of cross compiler ?
>>> Maybe there are some issues with cross compiling of the boot 
>>> wrapper...
>
> I suspect that there's some ELF sections which need to be dropped.
> Can you do an objdump -x on the vmlinux.elf-pmac with and without that
> patch and tell us which names are missing from the working one?  
> Thanks.

http://membres.lycos.fr/schaffner/objdump-x-diff

The problem is probably that the image of 2.6.4 has two LOAD commands.

On 01.04.2004, at 22:40, Olaf Hering wrote:

> This is fixed.  your options:
> update to 2.6.5-rc3
> disable modversions

Yes, 2.6.5-rc3 works. Thank you!

--
Martin Schaffner

