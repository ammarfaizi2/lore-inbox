Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310328AbSCPNBF>; Sat, 16 Mar 2002 08:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310330AbSCPNA4>; Sat, 16 Mar 2002 08:00:56 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:49280 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S310328AbSCPNAp>;
	Sat, 16 Mar 2002 08:00:45 -0500
Date: Sat, 16 Mar 2002 13:04:16 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Keith Owens <kaos@ocs.com.au>
cc: Paul Mackerras <paulus@samba.org>, Balbir Singh <balbir_soni@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules 
In-Reply-To: <16358.1016282075@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0203161300300.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Keith Owens wrote:
> I can see no good reason why the syscall table has been exported.

There are lots of good reasons why it has been exported, e.g. ability to
replace some system calls while leaving overall Linux personality (i.e.
without switching to an ABI emulation).

Ability to bypass the stupid commercial time-locked licences (at some time
wordperfect demo was locked like that and my timetravel module turned a
demo into full product -- users were happy, at least according to emails I
received :)

Also, ability to call those system calls from a module which are not
exported individually. Actually, the list of useful possibilities is
endless.  Wasn't it wine or dosemu (or some other similar software) which
was based on being able to access sys_call_table. I can't remember the
name of that software but I am sure that a lot of things will break if
sys_call_table is unexported.

Anyway, yes, I agree that this feature is mainly useful on i386
architecture. I should have explicitly stated this when I recommended it.

(actually, I didn't _recommend_ it but only listed it as a possiblity.
>From the possibilities that were originally listed I would recommend the
macro)

Regards,
Tigran

