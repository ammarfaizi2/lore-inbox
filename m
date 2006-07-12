Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWGLSad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWGLSad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWGLSad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:30:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:1426 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932317AbWGLSac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:30:32 -0400
Message-ID: <44B53FC4.9020601@us.ibm.com>
Date: Wed, 12 Jul 2006 11:30:28 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Ebbert <76306.1226@compuserve.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, hpa@zytor.com,
       Michael Holzheu <HOLZHEU@de.ibm.com>
Subject: Re: 2.6.18-rc1-mm1
References: <200607102302_MC3-1-C4A4-1385@compuserve.com> <20060710201506.7abbca37.rdunlap@xenotime.net> <44B33E7B.3040504@fr.ibm.com>
In-Reply-To: <44B33E7B.3040504@fr.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
> Randy.Dunlap wrote:
>   
>> On Mon, 10 Jul 2006 22:58:50 -0400 Chuck Ebbert wrote:
>>
>>     
>>> On Sun, 9 Jul 2006 02:11:06 -0700, Andrew morton wrote:
>>>
>>>       
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
>>>>         
>>> Warnings(?) during build:
>>>
>>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/ipconfig' given more than once in the same rule.
>>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/nfsmount' given more than once in the same rule.
>>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/run-init' given more than once in the same rule.
>>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/fstype' given more than once in the same rule.
>>>       
>> Yes, and these:
>>
>> fs/ecryptfs/main.c:327: warning: format ‘%d’ expects type ‘int’, but argument 3 has type ‘size_t’
>> fs/ecryptfs/crypto.c:1599: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
>> fs/ecryptfs/crypto.c:1621: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
>> fs/ecryptfs/crypto.c:1628: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
>> fs/ecryptfs/crypto.c:1635: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
>> fs/ecryptfs/crypto.c:1642: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
>> fs/ecryptfs/crypto.c:1649: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
>> fs/ecryptfs/crypto.c:1656: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
>> drivers/acpi/executer/exmutex.c:268: warning: format ‘%X’ expects type ‘unsigned int’, but argument 4 has type ‘struct task_struct *’
>> drivers/acpi/executer/exmutex.c:268: warning: format ‘%X’ expects type ‘unsigned int’, but argument 6 has type ‘struct task_struct *’
>>     
> ...

> arch/s390/hypfs/inode.c:432: warning: initialization from incompatible
> pointer type
> arch/s390/hypfs/inode.c:433: warning: initialization from incompatible
> pointer type
>
>   

Yuck. Its due to my vfs ops clean up changes.
Michael, do you have time to fix it up or do you want me to ?

Thanks,
Badari



