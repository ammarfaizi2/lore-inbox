Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264101AbTCXFBG>; Mon, 24 Mar 2003 00:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264108AbTCXFBG>; Mon, 24 Mar 2003 00:01:06 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:31482 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S264101AbTCXFAY>;
	Mon, 24 Mar 2003 00:00:24 -0500
From: Craig Dooley <cd5697@albany.edu>
To: linux-kernel@vger.kernel.org
Subject: nfs e100 slab errors
Date: Mon, 24 Mar 2003 00:11:08 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sNpf+twHGpFUQFi"
Message-Id: <200303240011.08786.cd5697@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_sNpf+twHGpFUQFi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using nfs to transfer 700meg file between two computers, I have repeated 
errors.  Attached is kernel config, and relevant dmesg output. Error seems to 
be related to kmalloc in ee100_rx_srv.

-Craig


--Boundary-00=_sNpf+twHGpFUQFi
Content-Type: text/plain;
  charset="us-ascii";
  name="messages"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="messages"

Mar 23 19:40:41 broken kernel: RPC: sendmsg returned error 101
Mar 23 19:40:41 broken kernel: nfs: RPC call returned error 101
Mar 23 19:40:41 broken kernel: RPC: sendmsg returned error 101
Mar 23 19:40:41 broken kernel: nfs: RPC call returned error 101
Mar 23 19:41:12 broken syslogd 1.4.1#11: restart.
Mar 23 20:35:39 broken kernel: nfs: server 192.168.0.1 not responding, stil=
l trying
Mar 23 20:35:49 broken last message repeated 4 times
Mar 23 20:35:54 broken kernel: 1 21 70 FF D1 65 3E 92 2B C5 EF BA 22 CA 6C =
7F E5 65 CA BD 34 48 82 5F F3 AA C7 FF FE 03 01 05 43 C9 12 68 66 66 61 C1 =
3B 1A 68 7D EC D6 AC A9 55 94 FD E6 C6 88 FA 2A CE 7B EA C0 9F C7 A5 9F DA =
0A B7 5F 4D E5 FF A5 47 85 80 13 B9 0C 85 30 A8 40 FA 1D 06 E5 FC B9 EB 70 =
0C 14 AC 42 10 AC 1F 88 D2 0F 25 05 2B 60 42 2E 94 F7 EF FF F9 3C 22 41 12 =
34 8D 7A 4B EE D2 4D 98 D1 D1 C8 80 CF A9 77 00 E1 7D F7 C1 92 42 F5 40 44 =
0F AA C4 0F CE 37 B4 B0 F9 E0 B2 C0 C7 FF F8 0A 45 3E 4B 9F 28 F3 C4 A1 24 =
21 FC 20 79 4C 08 4A C4 9F 33 47 DD BE 4F F5 5D A8 E1 C8 7A F0 8C 62 62 95 =
72 27 A4 C2 58 96 5F 04 90 3A AF D3 C5 ED DA AB 9E 1F A5 8C 2B 4E 0C 67 3F =
2C D5 59 49 89 B6 B1 47 7A 3F FF FF *B2 E3 D7 85 76 93 D8 31 57 F8 63 61 95=
 CB BC EB F1 91 08 6E 76 5E C6 89 C0 FA BD FA 96 55 B7 80 64 A1 4B 63 5F 7E=
 29 8A 17 2C AC 52 02 36 10 C6 51 5C A9 5D D8 A0 .FB 16 80 DF FF FF F7 C7 E=
7 F8 50 90 CF .A2 EB 0D 7C A2 8B 8B FC 3E 2F BE 52 AB D5 5F BD CB 7C 3B 50 =
B2 96 51 D3 66 4C 0C EC 17 F4 06 89 25 E0 1C 24 97=20
Mar 23 20:35:54 broken kernel: A D5 64 90 77 D9 BE 02 BE D5 3E 46 E7 76 7C =
D2 D8 25 D4 B0 12 01 73 1D E7 1F FE C6 73 FF 7A FF EE 1F 85 20 B0 A4 75 EF =
8E 93 C4 97 5B 48 30 06 80 1D BE 2F FA FE 2F B0 *27 A2 95 33 8A F8 0C 8F 01=
 8A 60 CC B9 5C D0 C9 .AA 79 0E 82 71 4A B8 B0 99 4C 1C 7C 9F DD 9A D9 DF F=
=46 D8 *4D 3D FD 55 C4 82 F1 24 79 54 48 A7 EC AD 09 01 8B 84 A2 EA 25 AB F=
A 9B C9 DF D6 44 EB 95 2E 54 AC 7B BC 51 FF 51 D8 65 A5 DE 06 D5 25 CB 01 D=
4 98 77 57 7C 56 19 AC 28 36 26 10 74 3A 71 A2 57 88 D0 5F B7 99 9A B5 64 1=
8 6E 31 54 5D FE C9 FE 5D CE D1 1D 20 62 0C EF 59 15 CC AE 78 85 85 BF 1F D=
1 28 0F A8 12 8B E7 F7 DE 56 A0 14 BE 9F 62 C0 2D 89 09 60 84 6C 54 26 C3 E=
3 A4 0B D8 34 4E 46 A6 03 45 2A 51 8B 13 8E 1F *3B FF FE 9D 62 AB 2E 3D 38 =
D4 50 CF 72 24 18 0E A8 30 5E 87 0A 69 EE D2 76 F2 1B 45 0B 4E CC A5 84 8D =
88 5F 32 E8 8B 8A 11 2C 2D AD CF FD 40 B5 08 36 18 0B CB 22 77 A7 E3 BE AF =
D7 CD C1 D4 9C AB 81 73 F2 A4 05 12 C2 2F D2 AD 13 0D 54 EE 62 F0 62 33 A0 =
4B 8A C2 10 F0 0F 0F C4 80 50 F8 47 1E C0 38 5F EA 05
Mar 23 20:35:54 broken kernel: B2 67 8F C1 B0 1B CD AA 08 60 D7 DA 22 51 F7=
 95 82 AF 71 F0 BE 8F 3D F5 79 6A 85 1E F4 03 3F 5B BC 43 C8 DB C1 A7 95 84=
 1D F2 B0 86 01 B0 B9 5D BA A8 48 2E FF A2 A0 60 29 55 AB 05 18 FD 2C 03 D1=
 60 C8 85 18 82 55 51 EB 13 40 AD C0 62 AF 0B D5 8E ED FD 2F 12 CB C4 9C DF=
 A9 1F F5 5E 51 1A 6C 93 48 4E 85 35 18 25 00 68 3C 07 F9 E2 5C 1F 51 F5 F8=
 1F 2E 1F 0F D5 7B B7 B6 03 11 84 20 0C 06 1F 80 70 FC 21 FB A0 7A 8F 6F B3=
 EB 61 38 40 12 C0 38 21 17 FF 2F B1 4D 97 F9 CD C4 C5 2E 07 80 81 04 03 FD=
 0B 84 91 F2 A0 6C 1E 2A D1 D5 5D 39 F2 F5 5E 2E BC C3 DE A7 C4 6D 0B D5 A8=
 CF 2A 50 DE 0C AD C9 0B 94 10 89 7E 2F 2E 2F A3 E5 1F 9F 98 C1 3C 1F DC A3=
 FF 35 55 0E DC 30 11 B0 6E 45 1F 1F AA 05 3F A5 1A 6C 06 3B 54 F8 7F E1 EA=
 AB 2D 9E 97 96 1A BE 57 A3 FA 94 18 E3 64 C2 4B 0B 8B 8B E1 7B 53 F2 40 33=
 0F 40 15 5E 23 C6 42 E3 E2 B3 A3 7C 9C 88 E0 55 D3 F4 D0 48 44 4C DE 4A BE=
 60 69 FF F7 65 7B 04 C4 9E B4 52 60 62 27 DD 94 21 61 A0 C6 A8 A9 34 A9 B1=
 40 53 6A 55 F9 52 9E 32 C7 8A 7F .F3 A5 EB 5E F5 F
Mar 23 20:35:54 broken kernel:  FF 94 A3 54 5D .4A AF 6D 07 C5 80 1C 03 01 =
04 18 7F F0 61 29 51 72 BB 01 E0 A0 17 12 47 E0 CA 00 3C 49 64 03 22 8D 12 =
95 FE 83 2C 3F 57 BE 1F AB 63 9A 6C 18 B8 1B E0 A1 12 41 A0 96 A8 1B CA E0 =
36 89 3E 83 E1 F0 FD 55 94 78 08 75 47 CB D5 2F F5 5E BF FF 88 38 7C 76 79 =
36 B7 E2 42 A2 F8 0D E9 04 B0 87 42 08 92 25 7D 40 92 5E 5E 3E 12 95 7C BF =
C3 FD 03 C5 F2 0F 95 78 79 55 5F 55 5F 93 96 5F 1C F8 D9 BB 26 D6 70 FD 53 =
54 68 F2 17 79 4A 89 22 8B 69 72 A5 D5 8F 15 7F AD FF 54 F4 45 7E EF 07 4D =
03 0B C2 9A 2A 95 97 78 49 12 47 CA F3 7E 24 2A 57 15 2A DE DA 5F 8A 47 E5 =
D2 88 FF 1D 0F 2F A0 1D ***************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************
Mar 23 20:35:54 broken kernel: ********************************************=
*********************************A5=20
Mar 23 20:35:54 broken kernel: Call Trace:
Mar 23 20:35:54 broken kernel:  [check_poison_obj+347/416] check_poison_obj=
+0x15b/0x1a0
Mar 23 20:35:54 broken kernel:  [kmalloc+361/448] kmalloc+0x169/0x1c0
Mar 23 20:35:54 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:35:54 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:35:54 broken kernel:  [e100_rx_srv+388/960] e100_rx_srv+0x184/0x3=
c0
Mar 23 20:35:54 broken kernel:  [e100intr+596/656] e100intr+0x254/0x290
Mar 23 20:35:54 broken kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0=
x38/0x60
Mar 23 20:35:54 broken kernel:  [do_IRQ+174/352] do_IRQ+0xae/0x160
Mar 23 20:35:54 broken kernel:  [common_interrupt+24/32] common_interrupt+0=
x18/0x20
Mar 23 20:35:54 broken kernel:  [acpi_processor_idle+346/495] acpi_processo=
r_idle+0x15a/0x1ef
Mar 23 20:35:54 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 23 20:35:54 broken kernel:  [acpi_processor_idle+0/495] acpi_processor_=
idle+0x0/0x1ef
Mar 23 20:35:54 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 23 20:35:54 broken kernel:  [cpu_idle+49/64] cpu_idle+0x31/0x40
Mar 23 20:35:54 broken kernel:  [rest_init+0/96] _stext+0x0/0x60
Mar 23 20:35:54 broken kernel:=20
Mar 23 20:35:54 broken kernel: A 0C 10 80 3F D1 4D F8 90 8B EA FE 0C 54 5C =
=460 83 E0 62 E0 82 3F B9 07 90 0B AB 04 35 4A 91 7D 58 FA 40 B9 B2 61 98 9=
0 AF FE 00 F0 60 50 83 0E E0 29 14 8F B5 78 3E E4 19 7C 02 40 38 18 7C 10 8=
B C4 81 F2 B5 45 F5 50 1B BF 8A 2D B3 2C 06 22 2F 1F 17 02 1F F2 64 8B 9D F=
=46 69 A4 28 55 4F AB 85 D7 EB 44 BC 40 4E 31 12 14 AA FE DE 79 1F D6 85 24=
 1B 55 41 D2 AB A3 F0 54 AA 1D 44 42 98 1F BB 61 3A 78 F3 C3 EF 64 9F E3 37=
 B2 8C 2E 7B 7E 3C 65 96 68 B0 6A 34 7F FF E8 BD 27 37 18 7B 7C 86 BB EB 63=
 0B A6 FF 5B 32 B6 25 17 8F D4 70 45 32 8D CB 34 25 2A 9F 32 79 84 A1 CD 50=
 68 64 43 8F 2B 99 A6 89 5E 32 A1 01 0C 0F C1 DD C0 3A D0 64 3D 52 3F 06 11=
 EF BF 40 A6 04 A3 5E B0 4A 97 E1 08 D4 2C FF F6 F1 AA 2F 43 61 4A 62 D0 B8=
 29 45 83 18 BC 36 52 .E1 8F AB 6A 6A 2A BB 7E 8A 20 58 *41 62 71 8C 3C 6C =
B7 A1 5B 79 F6 B8 7D B4 60 5B 43 DE F4 8B 68 5C E7 8A 14 D7 9D 5B 0C 75 33 =
BE A1 9A 23 C4 CA 4D 0F C0 2E F4 D0 CF 34 30 12 BC 5C 22 BD 94 46 81 7E 31 =
6F 16 65 C9 D2 33 DF FF AD 84 9B 58 4C CF 78 9C B0 F0 5
Mar 23 20:35:54 broken kernel:  50 21 74 04 F6 72 A7 8D 5B C1 3E B2 28 06 B=
6 D1 1A B1 99 A4 4B *0C 03 AB DE 7D 35 BA BC 88 2F 7B 7F CE 35 9B 1A BD 72 =
9D E1 3B 99 5B E2 87 39 F6 74 81 86 84 9F FF FF F6 1B 7F FF FF F7 30 31 77 =
62 80 02 00 00 45 00 61 87 1D 61 B3 66 AE *D4 2E DC 9A A2 9A 91 0D 13 0A 2A=
 CA 84 91 AD 7E 4B 48 A6 0E A3 CF 24 70 2C DD 8D 52 65 2B C1 4A E0 54 C0 AD=
 34 60 49 5B 96 1A 29 AD B4 30 87 E5 CC CD 46 30 C6 4C BF D7 9E 12 CF .82 7=
A 47 F4 CE 9A C9 9E B9 C7 29 B6 B9 07 82 68 FA 5C B5 53 DD FF C0 01 A0 *49 =
96 80 50 7C 02 81 81 16 36 7A 01 98 C6 A7 82 A3 AD 99 A2 00 15 20 22 3C E3 =
6D 31 C8 4C 78 7A 59 28 73 35 5D 79 CE 46 28 C8 84 64 63 C5 81 55 45 .46 3F=
 42 D2 43 AD 98 ED 2E 8F 10 38 00 0C 10 A8 2E A2 09 C2 08 9A 9A 15 72 3E BA=
 20 A9 70 .B2 09 A3 42 B5 EB 93 D5 BF E6 EF 59 D2 71 00 1A 08 74 B4 80 AA 1=
B A0 9C 25 A0 2E 5B 5B 68 4F 9A 1D 15 8D 60 82 82 5E 05 CF 8E C7 DC A6 94 9=
0 C4 A4 8E AB 28 69 29 33 8D 2B 1B 31 A3 38 73 B5 54 FA 35 1C AA 80 66 E0 8=
5 45 44 6D 7E D9 49 C9 A8 6E A9 EA 94 6E 2F 6C C6 3
Mar 23 20:35:54 broken kernel:  74 EF 80 47 35 D4 FF FB 92 64 E9 0E 43 43 3=
A 4C 13 4C 1D 92 56 C7 79 E7 61 E3 3C 0B CC E1 32 4C A4 76 89 89 16 A6 49 9=
4 8E 91 CF FB F2 8C 50 7F 94 F7 F4 BA 0F 90 00 B8 10 FD 25 88 83 18 38 BA C=
6 0A 20 6E 8D 83 15 82 70 80 F5 C6 2C 3A CE 4F 93 AD 87 FA E3 C7 2E 83 .63 =
B6 EB C0 D8 52 4A EB D0 50 DA 87 67 9A B4 DD 32 98 CA 36 44 18 8B 0F 03 42 =
8C 37 9E B4 B9 C1 A5 19 5B D5 9B 1B E7 D9 D1 85 B9 51 F9 CA 77 C0 4C A8 A2 =
45 89 08 26 4E 63 B9 3D EA 4B C0 5F 42 FE 18 80 C0 D4 E5 B5 4B 21 95 E0 C8 =
02 A0 52 A0 46 31 F1 7E 11 FD 96 03 8F 2C 3A 5D A1 A8 E4 B0 BF 1E 25 E9 49 =
0D 91 28 E4 F7 13 A2 9E 14 0D BD FD F2 C5 68 4B 69 66 80 28 F7 17 8A B7 76 =
23 57 17 AB 87 1E F4 44 56 CC D5 77 77 D5 5C 71 C7 FA F5 70 37 4B 81 B9 65 =
34 64 E2 64 E3 7C E7 BA 08 00 27 20 0F 8A 3E AB 58 D6 98 CA 73 98 E2 14 *D8=
 D2 56 EB F6 E3 29 DB 98 26 DB 74 E4 44 60 A2 10 1C 03 33 49 0A A7 22 06 89=
 9A 00 EF 5D 04 9A 88 60 23 73 80 CD 59 54 22 3C 22 71 69 7D C4 04 D4 44 44=
 62 4C D0 66 AD 50 91 CA B9 75 BE AA A5 33 67 .93 A
Mar 23 20:35:54 broken kernel:  66 EC AA 00 12 A4 01 7D 03 85 AD 03 2C 3C 6=
0 18 91 43 4C FC E0 89 0C 79 0F 38 08 21 4D C2 08 E6 4C 8D B0 A0 54 F2 30 3=
0 64 63 25 0F 00 00 00 00 01 B6 56 72 1C 0D EB 76 4F FF 92 5F D4 D2 DA 4E 8=
D 31 A4 D8 C2 3B D1 88 2D D4 FF 5B 1D 0E BC 06 2D DD 47 20 65 F8 AE 02 9B D=
=46 4B 47 FC 02 05 F0 5E 34 7F C0 77 44 79 91 B9 7C D8 2A FD 80 43 F0 93 6C=
 6E 4A 86 0D 85 E7 11 22 FA D5 85 1D 83 51 E9 BF B1 98 F1 F9 37 FF FF 13 6E=
 01 4C FE EB 53 00 AB 74 68 28 DF 65 ED B2 A8 EF 8D 89 42 58 21 E5 BE 80 87=
 AD AA D8 3D 4A 5D FE 68 30 14 56 DB 05 F0 D0 86 CF BD 62 BF 27 97 BA DA 4F=
 BA 28 96 A9 11 64 CD *****************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
*****************************************************
Mar 23 20:35:54 broken kernel: ********************************************=
*****************************A5=20
Mar 23 20:35:54 broken kernel: Call Trace:
Mar 23 20:35:54 broken kernel:  [check_poison_obj+347/416] check_poison_obj=
+0x15b/0x1a0
Mar 23 20:35:54 broken kernel:  [kmalloc+361/448] kmalloc+0x169/0x1c0
Mar 23 20:35:54 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:35:54 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:35:54 broken kernel:  [e100_rx_srv+388/960] e100_rx_srv+0x184/0x3=
c0
Mar 23 20:35:54 broken kernel:  [e100intr+596/656] e100intr+0x254/0x290
Mar 23 20:35:54 broken kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0=
x38/0x60
Mar 23 20:35:54 broken kernel:  [do_IRQ+174/352] do_IRQ+0xae/0x160
Mar 23 20:35:54 broken kernel:  [common_interrupt+24/32] common_interrupt+0=
x18/0x20
Mar 23 20:35:54 broken kernel:  [acpi_processor_idle+346/495] acpi_processo=
r_idle+0x15a/0x1ef
Mar 23 20:35:54 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 23 20:35:54 broken kernel:  [acpi_processor_idle+0/495] acpi_processor_=
idle+0x0/0x1ef
Mar 23 20:35:54 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 23 20:35:54 broken kernel:  [cpu_idle+49/64] cpu_idle+0x31/0x40
Mar 23 20:35:54 broken kernel:  [rest_init+0/96] _stext+0x0/0x60
Mar 23 20:35:54 broken kernel:=20
Mar 23 20:35:57 broken kernel: nfs: server 192.168.0.1 OK
Mar 23 20:35:57 broken last message repeated 4 times
Mar 23 20:55:16 broken kernel:  09 46 C3 54 9D 59 C6 7D 57 BE 8E 09 D3 CC F=
=46 11 51 30 53 05 70 6C 21 04 1B 82 53 62 2F 32 99 06 F8 30 20 03 C0 7F 9F=
 9E 06 1E 09 74 19 25 AD 11 03 09 0A 82 14 80 F0 7F F9 8F E1 74 58 47 56 04=
 20 BC 1A 03 29 00 E1 F0 30 8C 24 01 FA 06 47 E0 C3 87 5F 97 7B EA 87 99 7F=
 DE 56 8F 2A F2 BB EF 8F 75 41 20 53 2C 78 30 07 02 08 31 77 C2 00 92 0D A2=
 47 2E 81 D8 E0 84 25 09 77 FE 03 BE BE A1 62 BA 5E A4 74 D3 07 00 30 7E 0C=
 24 7C 47 A1 05 .AB 41 49 7F FF FC 54 AD 4A 99 21 7B 03 55 57 D9 74 19 C2 2=
D 2C 1B 50 AD 32 37 AB F1 74 57 AA C7 7C 6F 4C B9 22 1A D1 9D 87 BC 5E A6 1=
7 7D 40 8E 79 85 B8 D2 CB 91 26 16 DD F7 43 26 02 99 C0 69 06 F8 96 A0 BA 7=
C 4B 2F B6 D9 D4 F5 EA 80 38 7E AC 1B E1 06 8F C4 9B FF C2 E8 07 25 BC 0C 8=
2 10 37 C4 B5 65 E3 EF DF 6E 35 09 C0 38 18 B9 48 F8 7D F1 EE CF FE B4 65 5=
C 98 5D FB 44 71 1A 26 22 2E 57 FB F1 FF A4 11 9B A4 A1 4D EA 12 C1 95 09 6=
1 08 BC 18 49 12 CB C7 FE 57 7E 3B F2 BF B1 E8 C4 70 FC 18 BE 78 18 0F D1 2=
C 48 FE C1 FF A6 F8 0A 70 64 25 00 67 C1 87 94 4B FA=20
Mar 23 20:55:16 broken kernel: 7 F1 FA BD 1D 13 09 45 E3 FF 2B 53 BA DE C6 =
14 01 4C EB 87 AA A7 EF 20 8D 24 70 F3 F6 40 2B 69 F0 A7 28 48 F0 F4 70 4E =
25 89 14 7B C5 5E B5 23 82 18 07 78 21 97 64 06 05 02 AB E0 54 88 E8 7E 7C =
18 03 E5 06 DE 03 35 F0 53 51 D0 C8 4A 1F 89 54 BD 93 43 F1 F1 7C 54 60 3E =
46 03 C1 40 3B 53 E8 3C 6C 01 39 F0 60 C7 92 0C 4E 93 A2 45 EC 2A FE 68 7B =
BE 2D 0D BB 4E 09 A8 2B 0F C1 E1 73 02 99 02 44 B5 62 50 20 82 93 FE 57 13 =
72 8C D5 7E 7D 50 1D 2F FA B0 2C 5D 98 3B 05 48 5E 0C 08 33 21 90 65 60 82 =
3C 56 24 17 F8 45 F4 52 9C E0 37 B2 13 00 6E D2 70 36 21 1F 08 6D B1 FE 36 =
1E B5 FA BC 0E 03 40 90 4F 52 34 AA 5B E4 7F D5 23 13 AB 89 49 2A 55 72 01 =
4C 2B FD 24 77 1F B3 3C AB EC 81 26 86 40 B8 2D EC 40 14 C5 C4 82 F8 A8 10 =
C4 91 2E 34 25 7A 17 2A 06 02 BF 58 88 1E 06 02 11 23 E5 CA BE 3F AD FE 23 =
00 80 84 5C 10 0B D5 D5 43 EA 3B 54 A8 1B A2 .72 F5 62 26 B3 8E 06 1F CB 04=
 *07 89 9E 0D E7 84 3D 3C 14 C2 C8 34 54 3F 12 55 29 6C 7E 25 4B DF 17 8E E=
2 1B D7 04 30 80 24 AA 80 18 25 83 02 83 83 F0 37 7
Mar 23 20:55:16 broken kernel:  FE 26 C6 53 3C 18 4B 1E 0F 07 53 D2 C4 0F 0=
8 60 C0 84 24 7F FB ED 12 8B C0 B5 51 60 B8 1B C4 21 0D 4B 82 98 54 17 8F 8=
2 00 FC BD 5D 52 3F 57 55 FE B7 7F D3 60 F8 1F F2 84 3A 08 19 14 ED F2 B9 3=
B F0 50 7E 2A FA 7B 24 E5 4F 06 80 83 E5 2A 25 C5 32 B4 AD 50 EF D4 70 8C F=
0 30 94 5F E3 20 DF 2E FB 82 98 A0 .A0 1F E1 EF C7 7D CB E0 CC 48 61 5C 8D =
89 5F 52 0C 8A B6 34 00 D1 F8 F8 BC BC 7F 8A 95 7E F1 54 69 31 38 94 0C AF =
=46E 00 C1 E9 7A BE 97 83 08 C3 CF 08 DA 22 DF D4 86 3D FF 1F BE F9 E0 A6 1=
7 82 D0 FB D0 18 78 10 AC 06 11 44 BB 92 32 0A 08 0C 2D 06 C2 FB 2C 55 67 F=
4 0A 3C BC 7F E1 F8 30 28 47 A3 D1 13 54 E4 EF BC D6 2D 08 99 AA 68 8F 4E 8=
9 5F 12 94 D2 61 FF 87 E7 82 98 25 92 0C 08 00 C0 78 4B 1D 0E 84 7F A8 ED 7=
0 20 09 61 08 14 03 CD AA 58 3F 09 7D FF 52 FF 00 44 87 14 DD 72 37 8F F7 A=
9 C5 5E F7 FD C3 67 11 A4 60 D3 A9 9E 75 82 67 DF 5B 20 03 30 52 EA 89 7F 5=
0 22 25 79 FB 7B 7B 51 BC C2 7F AE 59 11 60 30 53 C2 BF 38 7D E1 44 09 41 C=
9 14 DE FE ED 7B 74 E7 EC CE 37 86 49 0F 07 30 5D 76=20
Mar 23 20:55:16 broken kernel: 6 D9 76 03 FB 28 9C BE 1C 9F 55 C8 12 7B 3F =
02 34 48 96 DC AC CB E4 5D 21 6F 4E 52 C8 DE D1 13 3A 34 5B 48 82 8E 12 03 =
02 08 30 43 04 21 20 78 01 82 57 A4 51 35 5F D9 AF 1F 89 23 FA 25 8F D5 97 =
D1 15 EA D5 17 2B 2F E2 AF 5F D4 CE 54 AA 67 A6 A3 7F FF D0 CC 29 42 C1 C0 =
C1 07 C0 C0 1E 10 D5 17 78 B9 54 55 E5 13 34 F0 96 3F 08 62 58 92 0C 23 AB =
BF 18 7D .A5 65 D7 15 C5 0F F4 F1 74 EC 93 A6 6D FA B6 AD 7B 80 F4 3E A8 1B=
 C2 5E 9E 12 47 C3 EA 01 62 30 41 85 A6 55 F1 CA BC 07 21 B2 E8 AC 7B FE 35=
 3B FA 49 4F 25 0E 0B 2E 2E A3 CF A9 50 0C 93 83 3A 3B B5 87 6A B5 3F A3 24=
 D0 D0 87 F2 F9 3C A3 CD 15 ***********************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************
Mar 23 20:55:16 broken kernel: ********************************************=
*************************************A5=20
Mar 23 20:55:16 broken kernel: Call Trace:
Mar 23 20:55:16 broken kernel:  [check_poison_obj+347/416] check_poison_obj=
+0x15b/0x1a0
Mar 23 20:55:16 broken kernel:  [kmalloc+361/448] kmalloc+0x169/0x1c0
Mar 23 20:55:16 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:55:16 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:55:16 broken kernel:  [e100_rx_srv+388/960] e100_rx_srv+0x184/0x3=
c0
Mar 23 20:55:16 broken kernel:  [e100intr+596/656] e100intr+0x254/0x290
Mar 23 20:55:16 broken kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0=
x38/0x60
Mar 23 20:55:16 broken kernel:  [do_IRQ+174/352] do_IRQ+0xae/0x160
Mar 23 20:55:16 broken kernel:  [common_interrupt+24/32] common_interrupt+0=
x18/0x20
Mar 23 20:55:16 broken kernel:  [kmem_cache_free+465/704] kmem_cache_free+0=
x1d1/0x2c0
Mar 23 20:55:16 broken kernel:  [d_callback+37/64] d_callback+0x25/0x40
Mar 23 20:55:16 broken kernel:  [d_callback+37/64] d_callback+0x25/0x40
Mar 23 20:55:16 broken kernel:  [rcu_do_batch+41/64] rcu_do_batch+0x29/0x40
Mar 23 20:55:16 broken kernel:  [rcu_process_callbacks+251/272] rcu_process=
_callbacks+0xfb/0x110
Mar 23 20:55:16 broken kernel:  [tasklet_action+70/112] tasklet_action+0x46=
/0x70
Mar 23 20:55:16 broken kernel:  [do_softirq+161/176] do_softirq+0xa1/0xb0
Mar 23 20:55:16 broken kernel:  [do_IRQ+282/352] do_IRQ+0x11a/0x160
Mar 23 20:55:16 broken kernel:  [common_interrupt+24/32] common_interrupt+0=
x18/0x20
Mar 23 20:55:16 broken kernel:  [acpi_processor_idle+346/495] acpi_processo=
r_idle+0x15a/0x1ef
Mar 23 20:55:16 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 23 20:55:16 broken kernel:  [acpi_processor_idle+0/495] acpi_processor_=
idle+0x0/0x1ef
Mar 23 20:55:16 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 23 20:55:16 broken kernel:  [cpu_idle+49/64] cpu_idle+0x31/0x40
Mar 23 20:55:16 broken kernel:  [rest_init+0/96] _stext+0x0/0x60
Mar 23 20:55:16 broken kernel:=20
Mar 23 20:55:48 broken kernel: ********************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************
Mar 23 20:55:48 broken kernel: ********************************************=
******************************************************************A5=20
Mar 23 20:55:48 broken kernel: Call Trace:
Mar 23 20:55:48 broken kernel:  [check_poison_obj+347/416] check_poison_obj=
+0x15b/0x1a0
Mar 23 20:55:48 broken kernel:  [kmalloc+361/448] kmalloc+0x169/0x1c0
Mar 23 20:55:48 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:55:48 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
Mar 23 20:55:48 broken kernel:  [e100_rx_srv+388/960] e100_rx_srv+0x184/0x3=
c0
Mar 23 20:55:48 broken kernel:  [e100intr+596/656] e100intr+0x254/0x290
Mar 23 20:55:48 broken kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0=
x38/0x60
Mar 23 20:55:48 broken kernel:  [do_IRQ+174/352] do_IRQ+0xae/0x160
Mar 23 20:55:48 broken kernel:  [common_interrupt+24/32] common_interrupt+0=
x18/0x20
Mar 23 20:55:48 broken kernel:=20

--Boundary-00=_sNpf+twHGpFUQFi
Content-Type: text/plain;
  charset="us-ascii";
  name="config-2.5.65"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config-2.5.65"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_NUMA is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=64
CONFIG_AIC7XXX_RESET_DELAY_MS=2000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
CONFIG_SCSI_QLOGIC_1280=y
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_XFRM_USER is not set
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_SCx200_ACB=m
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_PROC=m

#
# I2C Hardware Sensors Mainboard support
#
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_PIIX4 is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_LM75 is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP3 is not set
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_BIOS_REBOOT=y

--Boundary-00=_sNpf+twHGpFUQFi--

