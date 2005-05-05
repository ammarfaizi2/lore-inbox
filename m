Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVEEKR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVEEKR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 06:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVEEKR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 06:17:58 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:10390 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262028AbVEEKRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 06:17:45 -0400
Message-ID: <4279F2B3.4010409@ens-lyon.org>
Date: Thu, 05 May 2005 12:17:23 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash when unmounting NFS/TCP with -f
References: <4268EEC9.8010305@ens-lyon.org> <426945CC.6040100@tmr.com> <426DF305.7060109@ens-lyon.org>
In-Reply-To: <426DF305.7060109@ens-lyon.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin a écrit :
> The ssh command is just
> $ ssh kwad -L 2249:localhost:2049 -L 2248:localhost:870 -N -f
> (port is forwarded to 2249 while mountport if forwarded to 2248)
> 
> Options is /proc/mounts are
> rw,v2,rsize=8192,wsize=8192,hard,tcp,nolock,addr=localhost
> 
> I just had another network failure. I ran umount -f from vt1 to see
> kernel message. I waited for about 1 minute but didn't get any crash.
> So I switched back to X... and got the crash then.
> Looks like this crash doesn't want me to see any message...

I just got it through netconsole.
Unfortunatelly, the call trace doesn't appear.
Maybe the netconsole didn't have time send it before crashing.
Hope this helps.

Brice


RPC: error 5 connecting to server localhost
RPC: error 5 connecting to server localhost
RPC: error 5 connecting to server localhost
RPC: error 5 connecting to server localhost
RPC: error 5 connecting to server localhost
Unable to handle kernel paging request at virtual address ffffff98
 printing eip:
e0aaa07a
*pde = 00002067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT

Modules linked in: netconsole sd_mod usb_storage vfat fat loop isofs
zlib_inflate nls_cp850 nls_iso8859_15 smbfs nfs lockd sunrpc i915 tun
ipt_MASQUERADE iptable_nat ipt_state ip_conntrack iptable_filter
ip_tables floppy uhci_hcd ehci_hcd dm_mod snd_intel8x0 snd_ac97_codec

CPU:    0
EIP:    0060:[<e0aaa07a>]    Not tainted VLI
EFLAGS: 00010297   (2.6.11=Macvin)
EIP is at rpc_wake_up_status+0x6a/0x80 [sunrpc]
eax: ffffff84   ebx: d0065888   ecx: 00000001   edx: c146e000
esi: fffffffb   edi: d0065888   ebp: d0065800   esp: c146ef14
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c146e000 task=c1473020)
Stack: c146ef44 d0065800 00000283 fffffffb e0aa710e d0065888 fffffffb
00120dcb c1473184 00000000 d0065904
