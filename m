Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSDKPmq>; Thu, 11 Apr 2002 11:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314097AbSDKPmp>; Thu, 11 Apr 2002 11:42:45 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:52966 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S314094AbSDKPmm>; Thu, 11 Apr 2002 11:42:42 -0400
From: Christoph Rohland <cr@sap.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Geoffrey Gallaway <geoffeg@sin.sloth.org>, linux-kernel@vger.kernel.org
Subject: Re: Update - Ramdisks and tmpfs problems
In-Reply-To: <20020409144639.A14678@sin.sloth.org>
	<20020410102343.A31552@sin.sloth.org>
	<200204110600.g3B60UX08856@Port.imtp.ilyichevsk.odessa.ua>
Organisation: SAP LinuxLab
Date: Thu, 11 Apr 2002 17:47:01 +0200
Message-ID: <m3bscqw83u.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

On Thu, 11 Apr 2002, Denis Vlasenko wrote:
>> I am using a Dual Intel PIII 1Ghz box. When I use a SMP kernel AND
>> do multiple tmpfs mounts (mount --bind /dev/shm/etc /etc; mount
>> --bind /dev/shm/var /var) the machine goes into a reset
>> loop. HOWEVER, when I use a non-SMP kernel and still do multiple
>> tmpfs mounts OR when I use a SMP kernel and do only one tmpfs
>> mount, the machine boots fine. Every once in a while (1 out of 20
>> times?) the machine would boot fine with a SMP kernel and multiple
>> tmpfs mounts. Is this a timing issue?
> 
> Yes, sounds like race. It seems locking isn't quite right in tmpfs.

I am not sure. Could also be bad ram which only triggers under higher
load. I never had instant reboots on my machines due to races, but
only when I had bad DIMMs.

I also have multiple tmpfs instances on my 8-way test box where I
developed and tested tmpfs.

But you could be right. Unfortunately I do not have the time to
investigate further.

Greetings
		Christoph


