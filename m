Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135826AbRDYHL0>; Wed, 25 Apr 2001 03:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135825AbRDYHLP>; Wed, 25 Apr 2001 03:11:15 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:23803 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135831AbRDYHKz>; Wed, 25 Apr 2001 03:10:55 -0400
From: Christoph Rohland <cr@sap.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: "Tom Brusehaver (N-Sysdyne Corporation)" <Thomas.Brusehaver@lmco.com>,
        linux-kernel@vger.kernel.org
Subject: Re: shm_open doesn't work (fix maybe).
In-Reply-To: <3AE5ADDC.A7AA6F51@lmco.com>
	<20010424130140.P9725@devserv.devel.redhat.com>
Organisation: SAP LinuxLab
Date: 25 Apr 2001 09:08:32 +0200
In-Reply-To: <20010424130140.P9725@devserv.devel.redhat.com>
Message-ID: <m3g0exa233.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 Apr 2001, Jakub Jelinek wrote:
> On Tue, Apr 24, 2001 at 11:46:20AM -0500, Tom Brusehaver (N-Sysdyne
> Corporation) wrote:
>> 
>> I have been chasing all around trying to find out why
>> shm_open always returns ENOSYS. It is implemented
>> in glibc-2.2.2, and seems the 2.4.3 kernel knows about
>> shmfs.
>> 
>> It seems the file linux/mm/shmem.c has:
>>     #define SHMEM_MAGIC 0x01021994
>> 
>> And the glibc-2.2.2/sysdeps/unix/sysv/linux/linux_fsinfo.h has:
>>     #define SHMFS_SUPER_MAGIC 0x02011994
>> 
>> Well, which is correct?
> 
> Update your glibc, 2.2.3pre* matches 2.4.x kernel:
> 
> 2001-03-03  Ulrich Drepper  <drepper@redhat.com>
> 
> 	* sysdeps/unix/sysv/linux/linux_fsinfo.h (SHMFS_SUPER_MAGIC):
> 	Update for real 2.4 kernels.

Yes, and I apologize to Ulrich that the changed number slipped through
to the official kernel. My fault.

Greetings
		Christoph


