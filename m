Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVCVOmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVCVOmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVCVOmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:42:17 -0500
Received: from mail.rs4.huwig.de ([212.88.142.131]:16574 "HELO
	sponts.iku-ag.de") by vger.kernel.org with SMTP id S261312AbVCVOjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 09:39:14 -0500
Message-ID: <42402E0C.9020303@iku-ag.de>
Date: Tue, 22 Mar 2005 15:39:08 +0100
From: Kurt Huwig <k.huwig@iku-ag.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.29 on low memory and no swap
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig888122A213C0319A0BE3D39F"
X-SPONTS-Version: 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig888122A213C0319A0BE3D39F
Content-Type: multipart/mixed;
 boundary="------------070809030504090402080409"

This is a multi-part message in MIME format.
--------------070809030504090402080409
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

This machine has no swap at all.

The oops was hand-copied.
-- 
Kurt Huwig             iKu Systemhaus AG        http://www.iku-ag.de/
Vorstand               Am Römerkastell 4        Telefon 0681/96751-0
                        66121 Saarbrücken        Telefax 0681/96751-66
GnuPG 1024D/99DD9468 64B1 0C5B 82BC E16E 8940  EB6D 4C32 F908 99DD 9468

--------------070809030504090402080409
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

NULL pointer dereference at virtual address 00000004

printing eip:

c01330ec	
*pde=00000000
Oops=0002
CPU:    0
EIP:    0010:[<c01330ec>] Not tainted
EFLAGS: 00010046

eax: 00000000  ebx: c100001c  ecx: c112b8ac  edx: 00000000
esi: 00001000  ebp: c112b8d8  esp: c3abde14
ds:  0018  es: 0018  ss: 0018 

Process perl (pid: 17110, stackpage=c3abd000)

Stack:  c112b8ac  06cec067  001fc000  cb286bc4  
	000167f0  00001000  c112b8ac  c02f24fc
	c102c01c  c02f2538  00000212  ffffffff
	00002e76  c0133a0a  c0133e82  c112b8ac
        c0126ff2  c112b8ac  00000180  000001fc
        c0126dbd  06cec067  c49f8d80  c15e93a0

Call Trace: 	[<c0133a0a>]  [<c0133e82>]  [<c01267f2>]  [<c0126dbd>]
		[<c012985f>]  [<c0110bdb>]  [<c011ca95>]  [<c0121eec>]		
		[<c01088ef>]  [<c0116ee4>]  [<c01285b0>]  [<c0108bc4>]
		[<c0108af4>]  

Code: 	89 50 04 89 02  c7 45 00 00 00 
	00 00 c7 45 04  00 00 00 00 8b

--------------070809030504090402080409
Content-Type: text/plain;
 name="ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.txt"

ksymoops 2.4.9 on i686 2.6.8-2-k7.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /firma/data/iKu/Projekte/iKu/Sponts/sponts-kernel/2.4.29/System.map (specified)

c01330ec        
CPU:    0
EIP:    0010:[<c01330ec>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000  ebx: c100001c  ecx: c112b8ac  edx: 00000000
esi: 00001000  ebp: c112b8d8  esp: c3abde14
ds:  0018  es: 0018  ss: 0018 
Process perl (pid: 17110, stackpage=c3abd000)
Stack:  c112b8ac  06cec067  001fc000  cb286bc4  
        000167f0  00001000  c112b8ac  c02f24fc
        c102c01c  c02f2538  00000212  ffffffff
        00002e76  c0133a0a  c0133e82  c112b8ac
        c0126ff2  c112b8ac  00000180  000001fc
        c0126dbd  06cec067  c49f8d80  c15e93a0
Call Trace:     [<c0133a0a>]  [<c0133e82>]  [<c01267f2>]  [<c0126dbd>]
               [<c012985f>]  [<c0110bdb>]  [<c011ca95>]  [<c0121eec>]               
               [<c01088ef>]  [<c0116ee4>]  [<c01285b0>]  [<c0108bc4>]
               [<c0108af4>]  
Code:   89 50 04 89 02  c7 45 00 00 00 


>>EIP; c01330ec <__free_pages_ok+288/360>   <=====

Trace; c0133a0a <__free_pages+1e/20>
Trace; c0133e82 <free_page_and_swap_cache+32/34>
Trace; c01267f2 <__free_pte+62/68>
Trace; c0126dbd <zap_page_range+2dd/3f4>
Trace; c012985f <exit_mmap+c3/118>
Trace; c0110bdb <pci_check_direct+a7/f8>
Trace; c011ca95 <do_exit+c1/2e4>
Trace; c0121eec <block_all_signals+0/44>
Trace; c01088ef <do_signal+20b/26f>
Trace; c0116ee4 <do_page_fault+0/517>
Trace; c01285b0 <sys_brk+bc/e8>
Trace; c0108bc4 <error_code+34/40>
Trace; c0108af4 <signal_return+14/20>

Code;  c01330ec <__free_pages_ok+288/360>
00000000 <_EIP>:
Code;  c01330ec <__free_pages_ok+288/360>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c01330ef <__free_pages_ok+28b/360>
   3:   89 02                     mov    %eax,(%edx)
Code;  c01330f1 <__free_pages_ok+28d/360>
   5:   c7 45 00 00 00 00 00      movl   $0x0,0x0(%ebp)


--------------070809030504090402080409--

--------------enig888122A213C0319A0BE3D39F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCQC4MTDL5CJndlGgRAusGAKC/0GW1H2/BKrzFbR7FTHPd6Krp8ACgmvjX
UwYDPKUfoUXjZW7AP5Lj9ts=
=wNZE
-----END PGP SIGNATURE-----

--------------enig888122A213C0319A0BE3D39F--
