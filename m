Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTLSLB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 06:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTLSLB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 06:01:57 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:8151 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262608AbTLSLBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 06:01:52 -0500
Message-ID: <3FE2DA9E.9070206@namesys.com>
Date: Fri, 19 Dec 2003 14:01:50 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Teuber <teuber@devicen.de>
CC: Vladimir Saveliev <vs@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: 4 Oops with 2.4.23
References: <3FE240F9.5040703@devicen.de> <1071820223.15127.45.camel@tribesman.namesys.com> <3FE2BDD5.2020801@namesys.com> <3FE2D58D.8050804@devicen.de>
In-Reply-To: <3FE2D58D.8050804@devicen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Teuber wrote:

> Hans Reiser schrieb:
>
>> Vladimir Saveliev wrote:
>>
>>>
>>>> hi
>>>>
>>>> i had 4 Oops while running 2.4.23.
>>>>
>>>> all 4 Oops occured at the same address.
>>>>
>>>> two traces attached ...
>>>>
>>>> ksymoops 2.4.9 on i686 2.4.23.  Options used
>>>>     -v /usr/src/linux/vmlinux (specified)
>>>>     -k /proc/ksyms (default)
>>>>     -l /proc/modules (default)
>>>>     -o /lib/modules/2.4.23/ (default)
>>>>     -m /usr/src/linux/System.map (default)
>>>>
>>>> Reading Oops report from the terminal
>>>> Oops: 0000
>>>> CPU:    0
>>>> EIP:    0010:[<c0119780>]    Not tainted
>>>> Using defaults from ksymoops -t elf32-i386 -a i386
>>>> EFLAGS: 00010086
>>>> eax: c83a643c   ebx: 00000000   ecx: 00000001   edx: 00000001
>>>> esi: ce6d2980   edi: c83a643c   ebp: cdb61a6c   esp: cdb61a54
>>>> ds: 0018   es: 0018   ss: 0018
>>>> Process lpd (pid: 4136, stackpage=cdb61000)
>>>> Stack: 00000001 00000286 00000001 c41c1680 ce6d2980 00000000 00000046
>>>> c02282d4
>>>>       cfca1400 00000000 00000202 c41c1680 c022789b c41c1680 c8c9b180
>>>> c02288d1
>>>>       ce6d2980 cfca1560 fffffffd c022c7cb ce6d2980 cdb61af0 00000001
>>>> c033aa88
>>>> Call Trace:    [<c02282d4>] [<c022789b>] [<c02288d1>] [<c022c7cb>]
>>>> [<c0120bb1>]
>>>>  [<c010aa19>] [<c010cf18>] [<d094c782>] [<d094cbe4>] [<d094c3c0>]
>>>> [<d094d048>]
>>>>  [<d094ead2>] [<d094f0f2>] [<d095e82f>] [<d093d719>] [<d095e83d>]
>>>> [<d0955057>]
>>>>  [<d093ebd0>] [<d095e83d>] [<c0150356>] [<c013e224>] [<c013cd7d>]
>>>> [<c013ce0b>]
>>>>  [<c0108f27>]
>>>> Code: 8b 13 0f 18 02 39 c3 74 76 8d b4 26 00 00 00 00 8b 4b fc 8b
>>>>
>>>>
>>>>  
>>>>
>>>>>> EIP; c0119780 <__wake_up+20/b0>   <=====
>>>>>>       eax; c83a643c <_end+80372e8/1057bf0c>
>>>>>> esi; ce6d2980 <_end+e36382c/1057bf0c>
>>>>>> edi; c83a643c <_end+80372e8/1057bf0c>
>>>>>> ebp; cdb61a6c <_end+d7f2918/1057bf0c>
>>>>>> esp; cdb61a54 <_end+d7f2900/1057bf0c>
>>>>>>       
>>>>>
>>>>>
>>>> Trace; c02282d4 <sock_def_write_space+64/90>
>>>> Trace; c022789b <sock_wfree+3b/40>
>>>> Trace; c02288d1 <__kfree_skb+41/100>
>>>> Trace; c022c7cb <net_tx_action+2b/b0>
>>>> Trace; c0120bb1 <do_softirq+51/a0>
>>>> Trace; c010aa19 <do_IRQ+99/b0>
>>>> Trace; c010cf18 <call_do_IRQ+5/d>
>>>> Trace; d094c782 <[reiserfs]comp_keys+362/3f0>
>>>> Trace; d094cbe4 <[reiserfs]is_tree_node+64/70>
>>>> Trace; d094c3c0 <[reiserfs]__constant_memcpy+c0/120>
>>>> Trace; d094d048 <[reiserfs]search_for_position_by_key+f8/4c0>
>>>> Trace; d094ead2 <[reiserfs]reiserfs_cut_from_item+222/4b0>
>>>> Trace; d094f0f2 <[reiserfs]reiserfs_do_truncate+322/580>
>>>> Trace; d095e82f <[reiserfs].rodata.end+5ab0/5ca1>
>>>> Trace; d093d719 <[reiserfs]reiserfs_truncate_file+e9/230>
>>>> Trace; d095e83d <[reiserfs].rodata.end+5abe/5ca1>
>>>> Trace; d0955057 <[reiserfs]journal_end+27/30>
>>>> Trace; d093ebd0 <[reiserfs]reiserfs_file_release+3a0/450>
>>>
>>>
>>>
>> I would prefer that you first determine the likely cause of his 
>> needing to use fsck....  Did  he ever use write caching, command 
>> queueing, what exactly is the nature of the on-disk corruptio
>
>
> i don't think that this oops is related to reiserfs. i am not a kernel 
> hacker but
> every oops occurred in wake_up called from 
> <sock_def_write_space+64/90> ?!
>
> attached is a system description created with hwinfo from suse.
>
> the system is in production but i can originate an fsck to see if the 
> filesystem
> is damaged.
>
> yours, oliver teuber

I read the trace too fast, you are right.

-- 
Hans


