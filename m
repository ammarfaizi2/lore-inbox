Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAOHqh>; Mon, 15 Jan 2001 02:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRAOHq1>; Mon, 15 Jan 2001 02:46:27 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:24518 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S129632AbRAOHqR>; Mon, 15 Jan 2001 02:46:17 -0500
Message-ID: <006401c07ec6$03358f40$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: *Very* weird behavior from 2.2.14
Date: Mon, 15 Jan 2001 02:37:28 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0061_01C07E9C.1A37DB00"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

My machine is/has:
> Linux 2.2.14
> Red Hat 6.2
> Two PII 400 Mhz processors, but the kernel doesn't currently have SMP
support compiled in
> 256 MB RAM
> Two ethernet cards using PCI NE2000 (ne2k-pci.c), vpre-1.00e 5/27/99
> One SCSI hard drive (boot, using aic7xxx.o), and four IDE drives.
> Uptime of 93 days
> eth0 is network connection using DHCP (dhcpcd)
> eth1 is 100 MBPS LAN as address 192.168.1.1


Weird behavior is as follows:
1) When I ping other machines on the LAN from the linux machine, I get
unpredictable behavior.
Sometimes ping shows nothing, yet watching tcpdump and the hub between the
machines, it is
clear that the ICMPs are being sent and responded to accordingly in under 10
ms, but ping displays
nothing except for, at random intervals, a single response with a normal or
abnormally high time.
2) When I ping the machine's own IP (192.168.1.1), there is no network
activity as normal, but the
results reported are random. Sometimes there will be 100% packet loss, but
sometimes it will work
fine with intermitted periods of high ping times (going from 0.0 ms to 9000
ms). Strangely enough,
even when the machine can't ping itself, from other computers on the LAN, it
will respond fine.
3) I run samba to serve files to a windows machine on my LAN (192.168.1.70),
and file transfer
between them has suddenly become very slow. It was not like this before. I
watch tcpdump from
the linux machine and see the netbios packets happening at a slow rate,
sometimes stalling. When I
am streaming something like an mp3, the interrupts can last for 5 to 10
seconds and cause the mp3
to stop playing. This has never been this way before. It can even sometimes
cut out completely. This
is the first strange behavior I noticed after coming back from a week
vacation, while the machine was left
on.
4) This may or may not be related, but when I look up man-pages from tty1 as
any user, certain text,
such as variables names of C functions, do not show up on the screen. This
only happens on tty1.
They are perfectly fine on other terminals. I've tried "reset" to no
success.

Notes:
1) Attached are several pieces of log/program output to assist in debugging.
2)
The follow messages may or not be related. These types of messages have been
appearing in the
kernel ring buffer (dmesg) for some time but I have never paid attention to
it (nor do I know what it means):
eth0: bogus packet: status=0x80 nxpg=0x57 size=1438
eth0: bogus packet: status=0x80 nxpg=0x58 size=1518

3)  It has occured to me this may be due to outside attackers, but I have
found no evidence to
suggest this.



Regards and thanks,
Para-dox (paradox3@maine.rr.com)





------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="ifconfig"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ifconfig"

eth0      Link encap:Ethernet  HWaddr 00:20:78:14:5B:58  =0A=
          inet addr:66.30.9.198  Bcast:66.30.11.255  Mask:255.255.252.0=0A=
          UP BROADCAST NOTRAILERS RUNNING  MTU:1500  Metric:1=0A=
          RX packets:6752125 errors:29 dropped:0 overruns:0 frame:917=0A=
          TX packets:4592893 errors:2 dropped:0 overruns:0 carrier:2=0A=
          collisions:63712 txqueuelen:100 =0A=
          Interrupt:12 Base address:0xe800 =0A=
=0A=
eth1      Link encap:Ethernet  HWaddr 00:90:27:13:CB:52  =0A=
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0=0A=
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1=0A=
          RX packets:172552164 errors:0 dropped:0 overruns:0 frame:0=0A=
          TX packets:244419517 errors:0 dropped:0 overruns:0 carrier:0=0A=
          collisions:0 txqueuelen:100 =0A=
          Interrupt:11 Base address:0xb000 =0A=
=0A=
lo        Link encap:Local Loopback  =0A=
          inet addr:127.0.0.1  Mask:255.0.0.0=0A=
          UP LOOPBACK RUNNING  MTU:3924  Metric:1=0A=
          RX packets:1290545 errors:0 dropped:0 overruns:0 frame:0=0A=
          TX packets:1290545 errors:0 dropped:0 overruns:0 carrier:0=0A=
          collisions:0 txqueuelen:0 =0A=
=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="proc_cpuinfo"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_cpuinfo"

processor	: 0=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 6=0A=
model		: 5=0A=
model name	: Pentium II (Deschutes)=0A=
stepping	: 2=0A=
cpu MHz		: 400.917112=0A=
cache size	: 512 KB=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
sep_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 2=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 mmx fxsr=0A=
bogomips	: 399.77=0A=
=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="proc_interrupts"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_interrupts"

           CPU0       =0A=
  0:  807469438          XT-PIC  timer=0A=
  1:    3132252          XT-PIC  keyboard=0A=
  2:          0          XT-PIC  cascade=0A=
  5:    2605576          XT-PIC  aic7xxx=0A=
  8:          1          XT-PIC  rtc=0A=
 11:  282303934          XT-PIC  eth1=0A=
 12:   84463286          XT-PIC  eth0=0A=
 13:          1          XT-PIC  fpu=0A=
 14:   17970514          XT-PIC  ide0=0A=
 15:  940406438          XT-PIC  ide1=0A=
NMI:          0=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="proc_ioports"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_ioports"

0000-001f : dma1=0A=
0020-003f : pic1=0A=
0040-005f : timer=0A=
0060-006f : keyboard=0A=
0070-007f : rtc=0A=
0080-008f : dma page reg=0A=
00a0-00bf : pic2=0A=
00c0-00df : dma2=0A=
00f0-00ff : fpu=0A=
0170-0177 : ide1=0A=
01f0-01f7 : ide0=0A=
02f8-02ff : serial(auto)=0A=
0376-0376 : ide1=0A=
03c0-03df : vga+=0A=
03e8-03ef : serial(auto)=0A=
03f6-03f6 : ide0=0A=
03f8-03ff : serial(auto)=0A=
e800-e81f : eth0=0A=
ec00-ecbe : aic7xxx=0A=
f000-f007 : ide0=0A=
f008-f00f : ide1=0A=
d004b000-d004b01f : Intel Speedo3 Ethernet=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="route"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="route"

Kernel IP routing table=0A=
Destination     Gateway         Genmask         Flags Metric Ref    Use =
Iface=0A=
192.168.1.1     0.0.0.0         255.255.255.255 UH    0      0        0 =
eth1=0A=
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 =
eth1=0A=
66.30.8.0       0.0.0.0         255.255.252.0   U     0      0        0 =
eth0=0A=
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 =
lo=0A=
0.0.0.0         66.30.8.1       0.0.0.0         UG    0      0        0 =
eth0=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="rp_ping"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rp_ping"

Here I'm ping'ing another linux machine on the network.=0A=
I show the output of `date` at the beginning and the end so=0A=
you can see that the values are just nonsense, and also=0A=
so you can corroborate with the tcpdump output at the same=0A=
time, that the packets were sent and received consistently =0A=
at one second intervals the whole time.=0A=
=0A=
Mon Jan 15 01:30:20 EST 2001=0A=
=0A=
PING 192.168.1.4 (192.168.1.4) from 192.168.1.1 : 56(84) bytes of data.=0A=
64 bytes from 192.168.1.4: icmp_seq=3D0 ttl=3D255 time=3D0.6 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D1 ttl=3D255 time=3D5428.1 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D2 ttl=3D255 time=3D10010.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D3 ttl=3D255 time=3D14008.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D4 ttl=3D255 time=3D18008.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D5 ttl=3D255 time=3D22008.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D6 ttl=3D255 time=3D26009.2 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D7 ttl=3D255 time=3D26997.9 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D8 ttl=3D255 time=3D26022.7 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D9 ttl=3D255 time=3D25030.8 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D10 ttl=3D255 time=3D24038.6 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D11 ttl=3D255 time=3D23046.8 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D12 ttl=3D255 time=3D22084.8 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D13 ttl=3D255 time=3D21093.2 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D14 ttl=3D255 time=3D20101.0 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D15 ttl=3D255 time=3D19109.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D16 ttl=3D255 time=3D18117.7 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D17 ttl=3D255 time=3D17125.1 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D18 ttl=3D255 time=3D16133.1 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D19 ttl=3D255 time=3D15143.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D20 ttl=3D255 time=3D14153.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D21 ttl=3D255 time=3D13161.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D22 ttl=3D255 time=3D12188.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D23 ttl=3D255 time=3D11195.7 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D24 ttl=3D255 time=3D10207.8 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D25 ttl=3D255 time=3D9215.8 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D26 ttl=3D255 time=3D8226.0 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D27 ttl=3D255 time=3D7268.3 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D28 ttl=3D255 time=3D6277.2 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D29 ttl=3D255 time=3D5284.1 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D30 ttl=3D255 time=3D4292.2 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D31 ttl=3D255 time=3D3301.0 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D32 ttl=3D255 time=3D2308.8 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D33 ttl=3D255 time=3D1316.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D34 ttl=3D255 time=3D328.2 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D35 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D36 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D37 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D38 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D39 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D40 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D41 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D42 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D43 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D44 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D45 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D46 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D47 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D48 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D49 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D50 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D51 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D52 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D53 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D54 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D55 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D56 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D57 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D58 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D59 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D60 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D61 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D62 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D63 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D64 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D65 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D66 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D67 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D68 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D69 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D70 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D71 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D72 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D73 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D74 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D75 ttl=3D255 time=3D0.4 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D76 ttl=3D255 time=3D0.5 ms=0A=
64 bytes from 192.168.1.4: icmp_seq=3D77 ttl=3D255 time=3D0.4 ms=0A=
=0A=
--- 192.168.1.4 ping statistics ---=0A=
78 packets transmitted, 78 packets received, 0% packet loss=0A=
round-trip min/avg/max =3D 0.4/6131.5/26997.9 ms=0A=
=0A=
Mon Jan 15 01:31:38 EST 2001=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="rp_tcpdump"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rp_tcpdump"

Here is tcpdump output while pinging another linux machine on the=0A=
network, the output of `ping` is in another attached file:=0A=
=0A=
01:30:24.885979 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:24.886355 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:25.885902 > arp who-has 192.168.1.4 tell 192.168.1.1 =
(0:90:27:13:cb:52)=0A=
01:30:25.886191 < arp reply 192.168.1.4 is-at 0:20:78:14:80:f =
(0:90:27:13:cb:52)=0A=
01:30:25.886258 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:25.886603 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:26.885952 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:26.886324 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:27.885967 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:27.886339 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:28.885998 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:28.886381 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:29.885983 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:29.886365 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:30.885980 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:30.886355 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:31.885978 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:31.886360 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:32.885986 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:32.886365 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:33.885973 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:33.886349 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:34.885995 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:34.886373 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:35.885985 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:35.886363 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:36.885989 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:36.886371 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:37.885938 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:37.886303 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:38.885969 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:38.886344 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:39.885983 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:39.886362 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:40.885988 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:40.886368 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:41.885969 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:41.886344 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:42.885989 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:42.886365 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:43.885987 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:43.886364 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:44.885984 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:44.886361 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:45.885947 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:45.886318 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:46.885990 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:46.886371 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:47.885989 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:47.886364 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:48.885982 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:48.886365 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:49.885962 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:49.886339 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:50.885987 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:50.886366 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:51.885983 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:51.886365 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:52.885975 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:52.886345 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:53.885974 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:53.886349 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:54.885931 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:54.886298 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:55.885968 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:55.886345 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:56.885932 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:56.886297 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:57.885961 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:57.886333 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:58.885970 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:58.886349 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:30:59.885978 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:30:59.886355 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:00.885960 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:00.886335 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:01.885976 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:01.886361 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:02.885978 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:02.886362 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:03.885961 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:03.886335 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:04.885990 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:04.886368 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:05.885978 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:05.886355 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:06.885981 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:06.886364 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:07.885930 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:07.886297 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:08.885963 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:08.886338 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:09.885974 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:09.886357 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:10.885964 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:10.886339 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:11.884826 < arp who-has 192.168.1.1 tell 192.168.1.4=0A=
01:31:11.884870 > arp reply 192.168.1.1 (0:90:27:13:cb:52) is-at =
0:90:27:13:cb:52 (0:20:78:14:80:f)=0A=
01:31:11.885948 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:11.886300 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:12.885981 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:12.886360 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:13.885981 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:13.886359 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:14.885961 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:14.886335 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:15.885989 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:15.886371 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:16.885899 > arp who-has 192.168.1.4 tell 192.168.1.1 =
(0:90:27:13:cb:52)=0A=
01:31:16.886148 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:16.886189 < arp reply 192.168.1.4 is-at 0:20:78:14:80:f =
(0:90:27:13:cb:52)=0A=
01:31:16.886498 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:17.885968 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:17.886342 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:18.885970 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:18.886350 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:19.885959 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:19.886331 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:20.885977 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:20.886357 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:21.885931 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:21.886300 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:22.885965 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:22.886342 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:23.245699 B arp who-has 192.168.1.1 tell 192.168.1.176=0A=
01:31:23.245754 > arp reply 192.168.1.1 (0:90:27:13:cb:52) is-at =
0:90:27:13:cb:52 (0:10:a4:d0:f4:6a)=0A=
01:31:23.245875 < 192.168.1.176.1338 > 192.168.1.1.445: S =
2373847473:2373847473(0) win 16384 <mss 1460,nop,nop,sackOK> (DF)=0A=
01:31:23.245960 > 192.168.1.1.445 > 192.168.1.176.1338: R 0:0(0) ack =
2373847474 win 0=0A=
01:31:23.716083 < 192.168.1.176.1338 > 192.168.1.1.445: S =
2373847473:2373847473(0) win 16384 <mss 1460,nop,nop,sackOK> (DF)=0A=
01:31:23.716182 > 192.168.1.1.445 > 192.168.1.176.1338: R 0:0(0) ack 1 =
win 0=0A=
01:31:23.885970 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:23.886350 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:24.216867 < 192.168.1.176.1338 > 192.168.1.1.445: S =
2373847473:2373847473(0) win 16384 <mss 1460,nop,nop,sackOK> (DF)=0A=
01:31:24.216998 > 192.168.1.1.445 > 192.168.1.176.1338: R 0:0(0) ack 1 =
win 0=0A=
01:31:24.885976 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:24.886355 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:25.885959 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:25.886334 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:26.885975 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:26.886356 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:27.492685 B arp who-has 192.168.1.1 tell 192.168.1.8=0A=
01:31:27.492736 > arp reply 192.168.1.1 (0:90:27:13:cb:52) is-at =
0:90:27:13:cb:52 (0:8:c7:a2:0:f6)=0A=
01:31:27.885974 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:27.886355 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:28.245890 > arp who-has 192.168.1.176 tell 192.168.1.1 =
(0:90:27:13:cb:52)=0A=
01:31:28.246054 < arp reply 192.168.1.176 is-at 0:10:a4:d0:f4:6a =
(0:90:27:13:cb:52)=0A=
01:31:28.885962 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:28.886337 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:29.885978 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:29.886356 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:30.885974 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:30.886357 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:31.885962 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:31.886339 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:32.205548 > 192.168.1.1.domain > 192.168.1.176.1342: 26 2/6/6 =
CNAME gwyn.tux.org., A 207.96.122.8 (309)=0A=
01:31:32.495890 > arp who-has 192.168.1.8 tell 192.168.1.1 =
(0:90:27:13:cb:52)=0A=
01:31:32.496185 < arp reply 192.168.1.8 is-at 0:8:c7:a2:0:f6 =
(0:90:27:13:cb:52)=0A=
01:31:32.885957 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:32.886330 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:33.046161 > 192.168.1.1.domain > 192.168.1.176.1342: 26 2/4/4 =
CNAME gwyn.tux.org., A 207.96.122.8 (230)=0A=
01:31:33.046399 < 192.168.1.176 > 192.168.1.1: icmp: 192.168.1.176 udp =
port 1342 unreachable=0A=
01:31:33.885963 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:33.886337 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:34.885977 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:34.886356 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:35.885976 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:35.886354 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=
01:31:36.885976 > 192.168.1.1 > 192.168.1.4: icmp: echo request=0A=
01:31:36.886358 < 192.168.1.4 > 192.168.1.1: icmp: echo reply=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00
Content-Type: application/octet-stream;
	name="self_ping"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="self_ping"

Weird behavior when pinging my own IP address on eth1:=0A=
(Sometimes it doesn't even work)=0A=
=0A=
PING 192.168.1.1 (192.168.1.1) from 192.168.1.1 : 56(84) bytes of data.=0A=
64 bytes from 192.168.1.1: icmp_seq=3D0 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D1 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D2 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D3 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D4 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D5 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D6 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D7 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D8 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D9 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D10 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D11 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D12 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D13 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D14 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D15 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D16 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D17 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D18 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D19 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D20 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D21 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D22 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D23 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D24 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D25 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D26 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D27 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D28 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D29 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D30 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D31 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D32 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D33 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D34 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D35 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D36 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D37 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D38 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D39 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D40 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D41 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D42 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D43 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D44 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D45 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D46 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D47 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D48 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D49 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D50 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D51 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D52 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D53 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D54 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D55 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D56 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D57 ttl=3D255 time=3D9009.2 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D58 ttl=3D255 time=3D8025.4 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D59 ttl=3D255 time=3D7065.4 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D60 ttl=3D255 time=3D6075.4 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D61 ttl=3D255 time=3D5086.8 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D62 ttl=3D255 time=3D4093.6 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D63 ttl=3D255 time=3D3103.6 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D64 ttl=3D255 time=3D2111.8 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D65 ttl=3D255 time=3D1125.7 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D66 ttl=3D255 time=3D137.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D67 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D68 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D69 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D70 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D71 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D72 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D73 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D74 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D75 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D76 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D77 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D78 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D79 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D80 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D81 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D82 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D83 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D84 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D85 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D86 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D87 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D88 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D89 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D90 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D91 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D92 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D93 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D94 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D95 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D96 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D97 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D98 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D99 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D100 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D101 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D102 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D103 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D104 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D105 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D106 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D107 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D108 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D109 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D110 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D111 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D112 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D113 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D114 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D115 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D116 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D117 ttl=3D255 time=3D9008.4 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D118 ttl=3D255 time=3D8015.6 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D119 ttl=3D255 time=3D7025.3 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D120 ttl=3D255 time=3D6033.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D121 ttl=3D255 time=3D5041.9 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D122 ttl=3D255 time=3D4049.6 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D123 ttl=3D255 time=3D3057.6 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D124 ttl=3D255 time=3D2065.4 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D125 ttl=3D255 time=3D1074.5 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D126 ttl=3D255 time=3D83.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D127 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D128 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D129 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D130 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D131 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D132 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D133 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D134 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D135 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D136 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D137 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D138 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D139 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D140 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D141 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D142 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D143 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D144 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D145 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D146 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D147 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D148 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D149 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D150 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D151 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D152 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D153 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D154 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D155 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D156 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D157 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D158 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D159 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D160 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D161 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D162 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D163 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D164 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D165 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D166 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D167 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D168 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D169 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D170 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D171 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D172 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D173 ttl=3D255 time=3D9080.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D174 ttl=3D255 time=3D8127.7 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D175 ttl=3D255 time=3D7188.9 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D176 ttl=3D255 time=3D6220.9 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D177 ttl=3D255 time=3D5271.2 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D178 ttl=3D255 time=3D4338.8 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D179 ttl=3D255 time=3D3396.7 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D180 ttl=3D255 time=3D2476.4 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D181 ttl=3D255 time=3D1539.7 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D182 ttl=3D255 time=3D604.4 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D183 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D184 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D185 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D186 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D187 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D188 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D189 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D190 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D191 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D192 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D193 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D194 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D195 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D196 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D197 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D198 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D199 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D200 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D201 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D202 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D203 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D204 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D205 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D206 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D207 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D208 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D209 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D210 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D211 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D212 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D213 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D214 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D215 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D216 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D217 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D218 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D219 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D220 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D221 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D222 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D223 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D224 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D225 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D226 ttl=3D255 time=3D0.1 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D227 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D228 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D229 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D230 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D231 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D232 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D233 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D234 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D235 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D236 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D237 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D238 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D239 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D240 ttl=3D255 time=3D0.0 ms=0A=
64 bytes from 192.168.1.1: icmp_seq=3D241 ttl=3D255 time=3D0.0 ms=0A=
=0A=
--- 192.168.1.1 ping statistics ---=0A=
242 packets transmitted, 242 packets received, 0% packet loss=0A=
round-trip min/avg/max =3D 0.0/576.5/9080.1 ms=0A=

------=_NextPart_000_0061_01C07E9C.1A37DB00--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
