Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282684AbSADVrM>; Fri, 4 Jan 2002 16:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284669AbSADVrC>; Fri, 4 Jan 2002 16:47:02 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31190 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S282684AbSADVqk>; Fri, 4 Jan 2002 16:46:40 -0500
Message-ID: <3C3622BF.7010006@videotron.ca>
Date: Fri, 04 Jan 2002 16:46:39 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca> <20020103002827.GA4462@kroah.com> <3C33AF4F.7000703@videotron.ca> <20020103013231.GA4952@kroah.com> <3C33BD88.3010903@videotron.ca> <20020103030356.GA5313@kroah.com> <3C33CF71.4060202@videotron.ca> <20020103185730.GA11356@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------000109040603040608080509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000109040603040608080509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Greg KH wrote:

>
>When the seg-fault happens, I am guessing that an oops message is sent
>to the kernel log.  Look at 'dmesg'.  Run that oops through ksymoops.
>See Documentation/oops-tracing.txt for more info on oopses and how to
>get info from them.
>
>thanks,
>
>greg k-h
>
Sorry for the delay.

I found a lot of oopses and I managed to separate them in two files 
(attached). Each of the files correspond approx. to the time when I had 
the 2 seg-faults.

Thanks a lot for all your help Greg. It is really appreciated.

Happy New Year!

Roger Leblanc


--------------000109040603040608080509
Content-Type: text/plain;
 name="ksymoops.out.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.out.1"

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan  2 21:00:23 roger kernel:  <1>Unable to handle kernel paging request at virtual address a1ae3ae0
Jan  2 21:00:23 roger kernel: e614b46e
Jan  2 21:00:23 roger kernel: Oops: 0000
Jan  2 21:00:23 roger kernel: CPU:    0
Jan  2 21:00:23 roger kernel: EIP:    0010:[scanner:__insmod_scanner_O/lib/modules/2.4.17/kernel/drivers/usb/sc+-41200530/96]    Not tainted
Jan  2 21:00:23 roger kernel: EIP:    0010:[<e614b46e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  2 21:00:23 roger kernel: EFLAGS: 00010282
Jan  2 21:00:23 roger kernel: eax: c02b1466   ebx: dcd755a0   ecx: c031ade8   edx: 00000000
Jan  2 21:00:23 roger kernel: esi: e7ff91e0   edi: dcd75480   ebp: e252dba0   esp: e08fbf3c
Jan  2 21:00:23 roger kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 21:00:23 roger kernel: Process mozilla-bin (pid: 1986, stackpage=e08fb000)
Jan  2 21:00:23 roger kernel: Stack: c01ff4b0 dcd755a0 dcd75480 c01ffa40 dcd755a0 ffffffff e517f8c0 00000000 
Jan  2 21:00:23 roger kernel:        e517f8c0 c01344ce dcd75480 e517f8c0 000080d4 00000014 09266be0 bf5ff4b4 
Jan  2 21:00:23 roger kernel:        e517f8c0 e517f8c0 00000000 bf5ff404 c013332d e517f8c0 e2745580 00000000 
Jan  2 21:00:23 roger kernel: Call Trace: [sock_release+16/96] [sock_close+48/64] [fput+78/240] [filp_close+141/160] [sys_close+91/112] 
Jan  2 21:00:23 roger kernel: Call Trace: [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] [<c013332d>] [<c013339b>] 
Jan  2 21:00:23 roger kernel:    [<c0106f1b>] 
Jan  2 21:00:23 roger kernel: Code: 33 3c 7e b8 33 3c 7e b8 33 3c 0a 00 00 00 00 10 00 00 00 00 

>>EIP; e614b46e <_end+25e04bfa/2851978c>   <=====
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c013332c <filp_close+8c/a0>
Trace; c013339a <sys_close+5a/70>
Trace; c0106f1a <system_call+32/38>
Code;  e614b46e <_end+25e04bfa/2851978c>
00000000 <_EIP>:
Code;  e614b46e <_end+25e04bfa/2851978c>   <=====
   0:   33 3c 7e                  xor    (%esi,%edi,2),%edi   <=====
Code;  e614b470 <_end+25e04bfc/2851978c>
   3:   b8 33 3c 7e b8            mov    $0xb87e3c33,%eax
Code;  e614b476 <_end+25e04c02/2851978c>
   8:   33 3c 0a                  xor    (%edx,%ecx,1),%edi
Code;  e614b478 <_end+25e04c04/2851978c>
   b:   00 00                     add    %al,(%eax)
Code;  e614b47a <_end+25e04c06/2851978c>
   d:   00 00                     add    %al,(%eax)
Code;  e614b47c <_end+25e04c08/2851978c>
   f:   10 00                     adc    %al,(%eax)

Jan  2 21:00:23 roger kernel:  <1>Unable to handle kernel paging request at virtual address a8b4e5e0
Jan  2 21:00:23 roger kernel: e614b46e
Jan  2 21:00:23 roger kernel: Oops: 0000
Jan  2 21:00:23 roger kernel: CPU:    0
Jan  2 21:00:23 roger kernel: EIP:    0010:[scanner:__insmod_scanner_O/lib/modules/2.4.17/kernel/drivers/usb/sc+-41200530/96]    Not tainted
Jan  2 21:00:23 roger kernel: EIP:    0010:[<e614b46e>]    Not tainted
Jan  2 21:00:23 roger kernel: EFLAGS: 00010293
Jan  2 21:00:23 roger kernel: eax: c02b1466   ebx: e05aab20   ecx: c031ade8   edx: 00000000
Jan  2 21:00:23 roger kernel: esi: e7ff91e0   edi: e05aaa00   ebp: e06d28a0   esp: e17d7e48
Jan  2 21:00:23 roger kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 21:00:23 roger kernel: Process mozilla-bin (pid: 1966, stackpage=e17d7000)
Jan  2 21:00:23 roger kernel: Stack: c01ff4b0 e05aab20 e05aaa00 c01ffa40 e05aab20 ffffffff e04b5ce0 00000000 
Jan  2 21:00:23 roger kernel:        e04b5ce0 c01344ce e05aaa00 e04b5ce0 e17d4bfc e3679960 e7ffbce4 e3679960 
Jan  2 21:00:23 roger kernel:        00007fff e04b5ce0 00000000 00000011 c013332d e04b5ce0 e2745580 00000000 
Jan  2 21:00:23 roger kernel: Call Trace: [sock_release+16/96] [sock_close+48/64] [fput+78/240] [filp_close+141/160] [put_files_struct+77/208] 
Jan  2 21:00:23 roger kernel: Call Trace: [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] [<c013332d>] [<c011881d>] 
Jan  2 21:00:23 roger kernel:    [<c011901f>] [<c010ac98>] [<c0106dc4>] [<c013bf1a>] [<c01133c9>] [<c0106f54>] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; e614b46e <_end+25e04bfa/2851978c>   <=====
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c013332c <filp_close+8c/a0>
Trace; c011881c <put_files_struct+4c/d0>
Trace; c011901e <do_exit+10e/240>
Trace; c010ac98 <call_do_IRQ+6/e>
Trace; c0106dc4 <do_signal+244/2b0>
Trace; c013bf1a <pipe_write+20a/270>
Trace; c01133c8 <schedule+458/510>
Trace; c0106f54 <signal_return+14/18>


2 warnings issued.  Results may not be reliable.

--------------000109040603040608080509
Content-Type: text/plain;
 name="ksymoops.out.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.out.2"

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan  2 21:00:38 roger kernel:  <1>Unable to handle kernel paging request at virtual address aeed88e0
Jan  2 21:00:38 roger kernel: e614b46e
Jan  2 21:00:38 roger kernel: Oops: 0000
Jan  2 21:00:38 roger kernel: CPU:    0
Jan  2 21:00:38 roger kernel: EIP:    0010:[scanner:__insmod_scanner_O/lib/modules/2.4.17/kernel/drivers/usb/sc+-41200530/96]    Not tainted
Jan  2 21:00:38 roger kernel: EIP:    0010:[<e614b46e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  2 21:00:38 roger kernel: EFLAGS: 00013297
Jan  2 21:00:38 roger kernel: eax: c02b1466   ebx: e376fca0   ecx: c031ade8   edx: 00000000
Jan  2 21:00:38 roger kernel: esi: e7ff91e0   edi: e376fb80   ebp: e3729440   esp: e5099f3c
Jan  2 21:00:38 roger kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 21:00:38 roger kernel: Process X (pid: 1628, stackpage=e5099000)
Jan  2 21:00:38 roger kernel: Stack: c01ff4b0 e376fca0 e376fb80 c01ffa40 e376fca0 ffffffff e517f440 00000000 
Jan  2 21:00:38 roger kernel:        e517f440 c01344ce e376fb80 e517f440 0000000c e376fca0 e376fca0 0000000a 
Jan  2 21:00:38 roger kernel:        e517f440 e517f440 00000000 bffff758 c013332d e517f440 e6de76c0 00000000 
Jan  2 21:00:38 roger kernel: Call Trace: [sock_release+16/96] [sock_close+48/64] [fput+78/240] [filp_close+141/160] [sys_close+91/112] 
Jan  2 21:00:38 roger kernel: Call Trace: [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] [<c013332d>] [<c013339b>] 
Jan  2 21:00:38 roger kernel:    [<c0106f1b>] 
Jan  2 21:00:38 roger kernel: Code: 33 3c 7e b8 33 3c 7e b8 33 3c 0a 00 00 00 00 10 00 00 00 00 

>>EIP; e614b46e <_end+25e04bfa/2851978c>   <=====
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c013332c <filp_close+8c/a0>
Trace; c013339a <sys_close+5a/70>
Trace; c0106f1a <system_call+32/38>
Code;  e614b46e <_end+25e04bfa/2851978c>
00000000 <_EIP>:
Code;  e614b46e <_end+25e04bfa/2851978c>   <=====
   0:   33 3c 7e                  xor    (%esi,%edi,2),%edi   <=====
Code;  e614b470 <_end+25e04bfc/2851978c>
   3:   b8 33 3c 7e b8            mov    $0xb87e3c33,%eax
Code;  e614b476 <_end+25e04c02/2851978c>
   8:   33 3c 0a                  xor    (%edx,%ecx,1),%edi
Code;  e614b478 <_end+25e04c04/2851978c>
   b:   00 00                     add    %al,(%eax)
Code;  e614b47a <_end+25e04c06/2851978c>
   d:   00 00                     add    %al,(%eax)
Code;  e614b47c <_end+25e04c08/2851978c>
   f:   10 00                     adc    %al,(%eax)

Jan  2 21:00:38 roger kernel:  <1>Unable to handle kernel paging request at virtual address b21b72a0
Jan  2 21:00:38 roger kernel: e614b46e
Jan  2 21:00:38 roger kernel: Oops: 0000
Jan  2 21:00:38 roger kernel: CPU:    0
Jan  2 21:00:38 roger kernel: EIP:    0010:[scanner:__insmod_scanner_O/lib/modules/2.4.17/kernel/drivers/usb/sc+-41200530/96]    Not tainted
Jan  2 21:00:38 roger kernel: EIP:    0010:[<e614b46e>]    Not tainted
Jan  2 21:00:38 roger kernel: EFLAGS: 00013287
Jan  2 21:00:38 roger kernel: eax: c02b1466   ebx: e50df180   ecx: c031ade8   edx: 00000000
Jan  2 21:00:38 roger kernel: esi: e7ff91e0   edi: e50df060   ebp: e50d0760   esp: e5099d70
Jan  2 21:00:38 roger kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 21:00:38 roger kernel: Process X (pid: 1628, stackpage=e5099000)
Jan  2 21:00:38 roger kernel: Stack: c01ff4b0 e50df180 e50df060 c01ffa40 e50df180 ffffffff e4e7ff60 00000000 
Jan  2 21:00:38 roger kernel:        e4e7ff60 c01344ce e50df060 e4e7ff60 e4e22bfc e6ed1bc0 e7ffbce4 e6ed1bc0 
Jan  2 21:00:38 roger kernel:        03ffff7f e4e7ff60 00000000 00000003 c013332d e4e7ff60 e6de76c0 00000000 
Jan  2 21:00:38 roger kernel: Call Trace: [sock_release+16/96] [sock_close+48/64] [fput+78/240] [filp_close+141/160] [put_files_struct+77/208] 
Jan  2 21:00:38 roger kernel: Call Trace: [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] [<c013332d>] [<c011881d>] 
Jan  2 21:00:38 roger kernel:    [<c011901f>] [<c01122a0>] [<c0107464>] [<c0112698>] [<c01ff56c>] [<c01133c9>] 
Jan  2 21:00:38 roger kernel:    [<c0190530>] [<c01122e0>] [<c010700c>] [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] 
Jan  2 21:00:38 roger kernel:    [<c013332d>] [<c013339b>] [<c0106f1b>] 
Jan  2 21:00:38 roger kernel: Code: 33 3c 7e b8 33 3c 7e b8 33 3c 0a 00 00 00 00 10 00 00 00 00 

>>EIP; e614b46e <_end+25e04bfa/2851978c>   <=====
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c013332c <filp_close+8c/a0>
Trace; c011881c <put_files_struct+4c/d0>
Trace; c011901e <do_exit+10e/240>
Trace; c01122a0 <bust_spinlocks+50/60>
Trace; c0107464 <die+54/70>
Trace; c0112698 <do_page_fault+3b8/500>
Trace; c01ff56c <sock_sendmsg+6c/90>
Trace; c01133c8 <schedule+458/510>
Trace; c0190530 <normal_poll+110/130>
Trace; c01122e0 <do_page_fault+0/500>
Trace; c010700c <error_code+34/3c>
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c013332c <filp_close+8c/a0>
Trace; c013339a <sys_close+5a/70>
Trace; c0106f1a <system_call+32/38>
Code;  e614b46e <_end+25e04bfa/2851978c>
00000000 <_EIP>:
Code;  e614b46e <_end+25e04bfa/2851978c>   <=====
   0:   33 3c 7e                  xor    (%esi,%edi,2),%edi   <=====
Code;  e614b470 <_end+25e04bfc/2851978c>
   3:   b8 33 3c 7e b8            mov    $0xb87e3c33,%eax
Code;  e614b476 <_end+25e04c02/2851978c>
   8:   33 3c 0a                  xor    (%edx,%ecx,1),%edi
Code;  e614b478 <_end+25e04c04/2851978c>
   b:   00 00                     add    %al,(%eax)
Code;  e614b47a <_end+25e04c06/2851978c>
   d:   00 00                     add    %al,(%eax)
Code;  e614b47c <_end+25e04c08/2851978c>
   f:   10 00                     adc    %al,(%eax)

Jan  2 21:00:38 roger kernel:  <1>Unable to handle kernel paging request at virtual address ab7068e0
Jan  2 21:00:38 roger kernel: e614b46e
Jan  2 21:00:38 roger kernel: Oops: 0000
Jan  2 21:00:38 roger kernel: CPU:    0
Jan  2 21:00:38 roger kernel: EIP:    0010:[scanner:__insmod_scanner_O/lib/modules/2.4.17/kernel/drivers/usb/sc+-41200530/96]    Not tainted
Jan  2 21:00:38 roger kernel: EIP:    0010:[<e614b46e>]    Not tainted
Jan  2 21:00:38 roger kernel: EFLAGS: 00010286
Jan  2 21:00:38 roger kernel: eax: c02b1466   ebx: e1b86ca0   ecx: c031ade8   edx: 00000000
Jan  2 21:00:38 roger kernel: esi: e7ff91e0   edi: e1b86b80   ebp: e1bac1a0   esp: e33a9f3c
Jan  2 21:00:38 roger kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 21:00:38 roger kernel: Process ksmserver (pid: 1964, stackpage=e33a9000)
Jan  2 21:00:38 roger kernel: Stack: c01ff4b0 e1b86ca0 e1b86b80 c01ffa40 e1b86ca0 ffffffff e1c685e0 00000000 
Jan  2 21:00:38 roger kernel:        e1c685e0 c01344ce e1b86b80 e1c685e0 e1bcd2e0 c0141932 e1bcd2e0 00000004 
Jan  2 21:00:38 roger kernel:        e1c685e0 e1c685e0 00000000 bfffef58 c013332d e1c685e0 e2745a60 00000000 
Jan  2 21:00:38 roger kernel: Call Trace: [sock_release+16/96] [sock_close+48/64] [fput+78/240] [sys_select+1138/1152] [filp_close+141/160] 
Jan  2 21:00:38 roger kernel: Call Trace: [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] [<c0141932>] [<c013332d>] 
Jan  2 21:00:38 roger kernel:    [<c013339b>] [<c0106f1b>] 
Jan  2 21:00:38 roger kernel: Code: 33 3c 7e b8 33 3c 7e b8 33 3c 0a 00 00 00 00 10 00 00 00 00 

>>EIP; e614b46e <_end+25e04bfa/2851978c>   <=====
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c0141932 <sys_select+472/480>
Trace; c013332c <filp_close+8c/a0>
Trace; c013339a <sys_close+5a/70>
Trace; c0106f1a <system_call+32/38>
Code;  e614b46e <_end+25e04bfa/2851978c>
00000000 <_EIP>:
Code;  e614b46e <_end+25e04bfa/2851978c>   <=====
   0:   33 3c 7e                  xor    (%esi,%edi,2),%edi   <=====
Code;  e614b470 <_end+25e04bfc/2851978c>
   3:   b8 33 3c 7e b8            mov    $0xb87e3c33,%eax
Code;  e614b476 <_end+25e04c02/2851978c>
   8:   33 3c 0a                  xor    (%edx,%ecx,1),%edi
Code;  e614b478 <_end+25e04c04/2851978c>
   b:   00 00                     add    %al,(%eax)
Code;  e614b47a <_end+25e04c06/2851978c>
   d:   00 00                     add    %al,(%eax)
Code;  e614b47c <_end+25e04c08/2851978c>
   f:   10 00                     adc    %al,(%eax)

Jan  2 21:00:38 roger kernel:  <1>Unable to handle kernel paging request at virtual address aba84920
Jan  2 21:00:38 roger kernel: e614b46e
Jan  2 21:00:38 roger kernel: Oops: 0000
Jan  2 21:00:38 roger kernel: CPU:    0
Jan  2 21:00:38 roger kernel: EIP:    0010:[scanner:__insmod_scanner_O/lib/modules/2.4.17/kernel/drivers/usb/sc+-41200530/96]    Not tainted
Jan  2 21:00:38 roger kernel: EIP:    0010:[<e614b46e>]    Not tainted
Jan  2 21:00:38 roger kernel: EFLAGS: 00010213
Jan  2 21:00:38 roger kernel: eax: c02b1466   ebx: e1d45cc0   ecx: c031ade8   edx: 00000000
Jan  2 21:00:38 roger kernel: esi: e7ff91e0   edi: e1d45ba0   ebp: e1d1e0a0   esp: e33a9d70
Jan  2 21:00:38 roger kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 21:00:38 roger kernel: Process ksmserver (pid: 1964, stackpage=e33a9000)
Jan  2 21:00:38 roger kernel: Stack: c01ff4b0 e1d45cc0 e1d45ba0 c01ffa40 e1d45cc0 ffffffff e61a8120 00000000 
Jan  2 21:00:38 roger kernel:        e61a8120 c01344ce e1d45ba0 e61a8120 e2dacbfc e3679b40 e7ffbce4 e3679b40 
Jan  2 21:00:38 roger kernel:        00007fef e61a8120 00000000 00000003 c013332d e61a8120 e2745a60 00000000 
Jan  2 21:00:38 roger kernel: Call Trace: [sock_release+16/96] [sock_close+48/64] [fput+78/240] [filp_close+141/160] [put_files_struct+77/208] 
Jan  2 21:00:38 roger kernel: Call Trace: [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] [<c013332d>] [<c011881d>] 
Jan  2 21:00:38 roger kernel:    [<c011901f>] [<c01122a0>] [<c0107464>] [<c0112698>] [<c010657a>] [<c01066d4>] 
Jan  2 21:00:38 roger kernel:    [<c01122e0>] [<c010700c>] [<c01ff4b0>] [<c01ffa40>] [<c01344ce>] [<c0141932>] 
Jan  2 21:00:38 roger kernel:    [<c013332d>] [<c013339b>] [<c0106f1b>] 
Jan  2 21:00:38 roger kernel: Code: 33 3c 7e b8 33 3c 7e b8 33 3c 0a 00 00 00 00 10 00 00 00 00 

>>EIP; e614b46e <_end+25e04bfa/2851978c>   <=====
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c013332c <filp_close+8c/a0>
Trace; c011881c <put_files_struct+4c/d0>
Trace; c011901e <do_exit+10e/240>
Trace; c01122a0 <bust_spinlocks+50/60>
Trace; c0107464 <die+54/70>
Trace; c0112698 <do_page_fault+3b8/500>
Trace; c010657a <setup_sigcontext+da/120>
Trace; c01066d4 <setup_frame+114/210>
Trace; c01122e0 <do_page_fault+0/500>
Trace; c010700c <error_code+34/3c>
Trace; c01ff4b0 <sock_release+10/60>
Trace; c01ffa40 <sock_close+30/40>
Trace; c01344ce <fput+4e/f0>
Trace; c0141932 <sys_select+472/480>
Trace; c013332c <filp_close+8c/a0>
Trace; c013339a <sys_close+5a/70>
Trace; c0106f1a <system_call+32/38>
Code;  e614b46e <_end+25e04bfa/2851978c>
00000000 <_EIP>:
Code;  e614b46e <_end+25e04bfa/2851978c>   <=====
   0:   33 3c 7e                  xor    (%esi,%edi,2),%edi   <=====
Code;  e614b470 <_end+25e04bfc/2851978c>
   3:   b8 33 3c 7e b8            mov    $0xb87e3c33,%eax
Code;  e614b476 <_end+25e04c02/2851978c>
   8:   33 3c 0a                  xor    (%edx,%ecx,1),%edi
Code;  e614b478 <_end+25e04c04/2851978c>
   b:   00 00                     add    %al,(%eax)
Code;  e614b47a <_end+25e04c06/2851978c>
   d:   00 00                     add    %al,(%eax)
Code;  e614b47c <_end+25e04c08/2851978c>
   f:   10 00                     adc    %al,(%eax)

Jan  2 21:00:38 roger kernel:  <1>Unable to handle kernel paging request at virtual address a92eece0
Jan  2 21:00:38 roger kernel: e614b46e

1 warning issued.  Results may not be reliable.

--------------000109040603040608080509--

