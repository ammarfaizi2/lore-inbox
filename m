Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWGXAif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWGXAif (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 20:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWGXAif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 20:38:35 -0400
Received: from mail.infrasupportetc.com ([66.173.97.5]:12848 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S1751377AbWGXAie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 20:38:34 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6AEB9.7E1E0D38"
Content-class: urn:content-classes:message
Subject: 2.6.17.2 kernel bug?
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 23 Jul 2006 19:38:33 -0500
Message-ID: <925A849792280C4E80C5461017A4B8A206F83F@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17.2 kernel bug?
Thread-index: AcauuX4K3q9j4rhaQnWMjkL6agqeZw==
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AEB9.7E1E0D38
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This may be a hardware problem but I thought I should tell somebody.
It's running on a Dell Optiplex GX110, p3 733mhz, 256MB.  Below is an
extract from /var/log/messages.  I noticed these messages while I was in
a telnet session to that system.  Right now Nautilus on the console is
frozen in its screensaver.  This particular system is in a lab so I can
do what I want with it. =20

Like I said, this could be a hardware problem, or maybe it's a kernel
bug.  Apologies in advance if the below wraps.  In case the output below
is unintelligible, I will also attach bug.txt to this email.  It
contains the same output I pasted in below. =20

- Greg Scott

=20
=20
=20
=20
Jul 23 16:06:13 lakeville-fw kernel: SELinux: initialized (dev 0:11,
type nfs), uses genfs_contexts
Jul 23 16:26:37 lakeville-fw kernel: ------------[ cut here
]------------
Jul 23 16:26:37 lakeville-fw kernel: kernel BUG at mm/swapfile.c:352!
Jul 23 16:26:37 lakeville-fw kernel: invalid opcode: 0000 [#1]
Jul 23 16:26:37 lakeville-fw kernel: Modules linked in: nfs lockd
nfs_acl deflate zlib_deflate twofish serpent blowfish sha256 crypt
o_null aes des xfrm_user xfrm4_tunnel tunnel4 ipcomp esp4 ah4 af_key
cls_u32 sch_prio xt_state xt_tcpudp iptable_mangle iptable_filt
er ip_nat_h323 ip_conntrack_h323 ip_nat_pptp ip_conntrack_pptp
ip_conntrack_irc ip_nat_ftp ip_conntrack_ftp ipt_owner iptable_nat ip
_tables ipt_MASQUERADE ip_nat ip_conntrack nfnetlink ipt_REJECT ipt_LOG
x_tables ppdev autofs4 hidp rfcomm l2cap bluetooth sunrpc dm
_mirror dm_mod video button battery ac ipv6 lp parport_pc parport floppy
nvram uhci_hcd snd_intel8x0 snd_ac97_codec snd_ac97_bus snd
_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 3c59x
mii snd_pcm_oss snd_mixer_oss snd_pcm snd_timer hw_random i2c
_i810 i2c_algo_bit snd soundcore snd_page_alloc i2c_i801 i2c_core ext3
jbd
Jul 23 16:26:37 lakeville-fw kernel: CPU:    0
Jul 23 16:26:37 lakeville-fw kernel: EIP:    0060:[<c0149c94>]    Not
tainted VLI
Jul 23 16:26:37 lakeville-fw kernel: EFLAGS: 00210202   (2.6.17.2fw21
#1)=20
Jul 23 16:26:37 lakeville-fw kernel: EIP is at
remove_exclusive_swap_page+0xb/0xe3
Jul 23 16:26:37 lakeville-fw kernel: eax: 8000ff61   ebx: c11deae0
ecx: c03d621c   edx: c11deae0
Jul 23 16:26:37 lakeville-fw kernel: esi: 08125000   edi: c2613494
ebp: 0ef57067   esp: cd668e04
Jul 23 16:26:37 lakeville-fw kernel: ds: 007b   es: 007b   ss: 0068
Jul 23 16:26:37 lakeville-fw kernel: Process floaters (pid: 4875,
threadinfo=3Dcd668000 task=3Dc292b050)
Jul 23 16:26:37 lakeville-fw kernel: Stack: c11deae0 08125000 c0149109
c11deae0 c0142645 00000000 c1cda494 cd668e7c=20
Jul 23 16:26:37 lakeville-fw kernel:        00227c93 00000000 00000001
08400000 c22b4080 c5d6a2a0 c03d621c ffffff29=20
Jul 23 16:26:37 lakeville-fw kernel:        00000000 c5d6a2f0 c22b4080
08676000 00000000 cd668e7c c2c1a4ec c5d6a2a0=20
Jul 23 16:26:37 lakeville-fw kernel: Call Trace:
Jul 23 16:26:37 lakeville-fw kernel:  <c0149109>
free_page_and_swap_cache+0x1b/0x2a  <c0142645> unmap_vmas+0x297/0x490
Jul 23 16:26:37 lakeville-fw kernel:  <c0144ddd> exit_mmap+0x50/0xbc
<c011814e> mmput+0x1f/0x76
Jul 23 16:26:37 lakeville-fw kernel:  <c011c5d7> do_exit+0x18a/0x6ca
<c011cb84> sys_exit_group+0x0/0xd
Jul 23 16:26:37 lakeville-fw kernel:  <c012363e>
get_signal_to_deliver+0x347/0x38b  <c01021be>
do_notify_resume+0x6f/0x5b8
Jul 23 16:26:37 lakeville-fw kernel:  <c02cc7e5> unix_ioctl+0xa3/0xac
<c02d2fa5> _spin_unlock_irq+0x5/0x7
Jul 23 16:26:37 lakeville-fw kernel:  <c02d1db4> schedule+0x49e/0x4fa
<c0102ae6> work_notifysig+0x13/0x19
Jul 23 16:26:37 lakeville-fw kernel: Code: 0b 8b 48 14 85 c9 74 04 89 da
ff d1 b8 40 99 33 c0 83 ca ff 0f c1 10 0f 88 b1 14 00 00 5b
 5e c3 56 53 89 c3 8b 00 f6 c4 08 74 08 <0f> 0b 60 01 bf 2b 2f c0 8b 03
a8 01 75 08 0f 0b 61 01 bf 2b 2f=20
Jul 23 16:26:37 lakeville-fw kernel: EIP: [<c0149c94>]
remove_exclusive_swap_page+0xb/0xe3 SS:ESP 0068:cd668e04
Jul 23 16:26:37 lakeville-fw kernel:  <3>BUG: sleeping function called
from invalid context at include/linux/rwsem.h:43
Jul 23 16:26:37 lakeville-fw kernel: in_atomic():1, irqs_disabled():0
Jul 23 16:26:37 lakeville-fw kernel:  <c012431d>
blocking_notifier_call_chain+0x18/0x49  <c011c469> do_exit+0x1c/0x6ca
Jul 23 16:26:37 lakeville-fw kernel:  <c0103d08> die+0x1af/0x264
<c0103d98> die+0x23f/0x264
Jul 23 16:26:37 lakeville-fw kernel:  <c0104329> do_invalid_op+0x0/0x9d
<c01043ba> do_invalid_op+0x91/0x9d
Jul 23 16:26:37 lakeville-fw kernel:  <c0149c94>
remove_exclusive_swap_page+0xb/0xe3  <c0116943> try_to_wake_up+0xe9/0xf3
Jul 23 16:26:37 lakeville-fw kernel:  <c0116453>
__wake_up_common+0x2f/0x53  <c0116acf> __wake_up+0x2a/0x3d
Jul 23 16:26:37 lakeville-fw kernel:  <c010350f> error_code+0x4f/0x54
<c0149c94> remove_exclusive_swap_page+0xb/0xe3
Jul 23 16:26:37 lakeville-fw kernel:  <c0149109>
free_page_and_swap_cache+0x1b/0x2a  <c0142645> unmap_vmas+0x297/0x490
Jul 23 16:26:37 lakeville-fw kernel:  <c0144ddd> exit_mmap+0x50/0xbc
<c011814e> mmput+0x1f/0x76
Jul 23 16:26:37 lakeville-fw kernel:  <c011c5d7> do_exit+0x18a/0x6ca
<c011cb84> sys_exit_group+0x0/0xd
Jul 23 16:26:37 lakeville-fw kernel:  <c012363e>
get_signal_to_deliver+0x347/0x38b  <c01021be>
do_notify_resume+0x6f/0x5b8
Jul 23 16:26:37 lakeville-fw kernel:  <c02cc7e5> unix_ioctl+0xa3/0xac
<c02d2fa5> _spin_unlock_irq+0x5/0x7
Jul 23 16:26:37 lakeville-fw kernel:  <c02d1db4> schedule+0x49e/0x4fa
<c0102ae6> work_notifysig+0x13/0x19
Jul 23 16:26:37 lakeville-fw kernel: Fixing recursive fault but reboot
is needed!
Jul 23 16:26:37 lakeville-fw kernel: BUG: scheduling while atomic:
floaters/0x00000001/4875
Jul 23 16:26:37 lakeville-fw kernel:  <c02d1959> schedule+0x43/0x4fa
<c01b89a4> cfq_free_io_context+0x2a/0x54
Jul 23 16:26:37 lakeville-fw kernel:  <c011c518> do_exit+0xcb/0x6ca
<c0103d08> die+0x1af/0x264
Jul 23 16:26:37 lakeville-fw kernel:  <c0103d98> die+0x23f/0x264
<c0104329> do_invalid_op+0x0/0x9d
Jul 23 16:26:37 lakeville-fw kernel:  <c01043ba> do_invalid_op+0x91/0x9d
<c0149c94> remove_exclusive_swap_page+0xb/0xe3
Jul 23 16:26:37 lakeville-fw kernel:  <c0116943>
try_to_wake_up+0xe9/0xf3  <c0116453> __wake_up_common+0x2f/0x53
Jul 23 16:26:37 lakeville-fw kernel:  <c0116acf> __wake_up+0x2a/0x3d
<c010350f> error_code+0x4f/0x54
Jul 23 16:26:37 lakeville-fw kernel:  <c0149c94>
remove_exclusive_swap_page+0xb/0xe3  <c0149109>
free_page_and_swap_cache+0x1b/0x2a
Jul 23 16:26:37 lakeville-fw kernel:  <c0142645> unmap_vmas+0x297/0x490
<c0144ddd> exit_mmap+0x50/0xbc
Jul 23 16:26:37 lakeville-fw kernel:  <c011814e> mmput+0x1f/0x76
<c011c5d7> do_exit+0x18a/0x6ca
Jul 23 16:26:37 lakeville-fw kernel:  <c011cb84> sys_exit_group+0x0/0xd
<c012363e> get_signal_to_deliver+0x347/0x38b
Jul 23 16:26:37 lakeville-fw kernel:  <c01021be>
do_notify_resume+0x6f/0x5b8  <c02cc7e5> unix_ioctl+0xa3/0xac
Jul 23 16:26:37 lakeville-fw kernel:  <c02d2fa5>
_spin_unlock_irq+0x5/0x7  <c02d1db4> schedule+0x49e/0x4fa
Jul 23 16:26:37 lakeville-fw kernel:  <c0102ae6>
work_notifysig+0x13/0x19=20
Jul 23 16:26:37 lakeville-fw kernel: audit(1153689997.416:24): avc:
denied  { write } for  pid=3D4916 comm=3D"syslogd" name=3D"3" dev=3Ddev
pts ino=3D5 scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Duser_u:object_r:telnetd_devpts_t:s0 tclass=3Dchr_file
Jul 23 16:26:37 lakeville-fw kernel: audit(1153689997.416:25): avc:
denied  { getattr } for  pid=3D4916 comm=3D"syslogd" name=3D"3" dev=3Dd
evpts ino=3D5 scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Duser_u:object_r:telnetd_devpts_t:s0 tclass=3Dchr_file

------_=_NextPart_001_01C6AEB9.7E1E0D38
Content-Type: text/plain;
	name="bug.txt"
Content-Transfer-Encoding: base64
Content-Description: bug.txt
Content-Disposition: attachment;
	filename="bug.txt"

IA0KSnVsIDIzIDE2OjA2OjEzIGxha2V2aWxsZS1mdyBrZXJuZWw6IFNFTGludXg6IGluaXRpYWxp
emVkIChkZXYgMDoxMSwgdHlwZSBuZnMpLCB1c2VzIGdlbmZzX2NvbnRleHRzDQpKdWwgMjMgMTY6
MjY6MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0t
LS0tLS0tDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDoga2VybmVsIEJVRyBh
dCBtbS9zd2FwZmlsZS5jOjM1MiENCkp1bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncga2VybmVs
OiBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3
IGtlcm5lbDogTW9kdWxlcyBsaW5rZWQgaW46IG5mcyBsb2NrZCBuZnNfYWNsIGRlZmxhdGUgemxp
Yl9kZWZsYXRlIHR3b2Zpc2ggc2VycGVudCBibG93ZmlzaCBzaGEyNTYgY3J5cHQNCm9fbnVsbCBh
ZXMgZGVzIHhmcm1fdXNlciB4ZnJtNF90dW5uZWwgdHVubmVsNCBpcGNvbXAgZXNwNCBhaDQgYWZf
a2V5IGNsc191MzIgc2NoX3ByaW8geHRfc3RhdGUgeHRfdGNwdWRwIGlwdGFibGVfbWFuZ2xlIGlw
dGFibGVfZmlsdA0KZXIgaXBfbmF0X2gzMjMgaXBfY29ubnRyYWNrX2gzMjMgaXBfbmF0X3BwdHAg
aXBfY29ubnRyYWNrX3BwdHAgaXBfY29ubnRyYWNrX2lyYyBpcF9uYXRfZnRwIGlwX2Nvbm50cmFj
a19mdHAgaXB0X293bmVyIGlwdGFibGVfbmF0IGlwDQpfdGFibGVzIGlwdF9NQVNRVUVSQURFIGlw
X25hdCBpcF9jb25udHJhY2sgbmZuZXRsaW5rIGlwdF9SRUpFQ1QgaXB0X0xPRyB4X3RhYmxlcyBw
cGRldiBhdXRvZnM0IGhpZHAgcmZjb21tIGwyY2FwIGJsdWV0b290aCBzdW5ycGMgZG0NCl9taXJy
b3IgZG1fbW9kIHZpZGVvIGJ1dHRvbiBiYXR0ZXJ5IGFjIGlwdjYgbHAgcGFycG9ydF9wYyBwYXJw
b3J0IGZsb3BweSBudnJhbSB1aGNpX2hjZCBzbmRfaW50ZWw4eDAgc25kX2FjOTdfY29kZWMgc25k
X2FjOTdfYnVzIHNuZA0KX3NlcV9kdW1teSBzbmRfc2VxX29zcyBzbmRfc2VxX21pZGlfZXZlbnQg
c25kX3NlcSBzbmRfc2VxX2RldmljZSAzYzU5eCBtaWkgc25kX3BjbV9vc3Mgc25kX21peGVyX29z
cyBzbmRfcGNtIHNuZF90aW1lciBod19yYW5kb20gaTJjDQpfaTgxMCBpMmNfYWxnb19iaXQgc25k
IHNvdW5kY29yZSBzbmRfcGFnZV9hbGxvYyBpMmNfaTgwMSBpMmNfY29yZSBleHQzIGpiZA0KSnVs
IDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6IENQVTogICAgMA0KSnVsIDIzIDE2OjI2
OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6IEVJUDogICAgMDA2MDpbPGMwMTQ5Yzk0Pl0gICAgTm90
IHRhaW50ZWQgVkxJDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogRUZMQUdT
OiAwMDIxMDIwMiAgICgyLjYuMTcuMmZ3MjEgIzEpIA0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxs
ZS1mdyBrZXJuZWw6IEVJUCBpcyBhdCByZW1vdmVfZXhjbHVzaXZlX3N3YXBfcGFnZSsweGIvMHhl
Mw0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6IGVheDogODAwMGZmNjEgICBl
Yng6IGMxMWRlYWUwICAgZWN4OiBjMDNkNjIxYyAgIGVkeDogYzExZGVhZTANCkp1bCAyMyAxNjoy
NjozNyBsYWtldmlsbGUtZncga2VybmVsOiBlc2k6IDA4MTI1MDAwICAgZWRpOiBjMjYxMzQ5NCAg
IGVicDogMGVmNTcwNjcgICBlc3A6IGNkNjY4ZTA0DQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxl
LWZ3IGtlcm5lbDogZHM6IDAwN2IgICBlczogMDA3YiAgIHNzOiAwMDY4DQpKdWwgMjMgMTY6MjY6
MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogUHJvY2VzcyBmbG9hdGVycyAocGlkOiA0ODc1LCB0aHJl
YWRpbmZvPWNkNjY4MDAwIHRhc2s9YzI5MmIwNTApDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxl
LWZ3IGtlcm5lbDogU3RhY2s6IGMxMWRlYWUwIDA4MTI1MDAwIGMwMTQ5MTA5IGMxMWRlYWUwIGMw
MTQyNjQ1IDAwMDAwMDAwIGMxY2RhNDk0IGNkNjY4ZTdjIA0KSnVsIDIzIDE2OjI2OjM3IGxha2V2
aWxsZS1mdyBrZXJuZWw6ICAgICAgICAwMDIyN2M5MyAwMDAwMDAwMCAwMDAwMDAwMSAwODQwMDAw
MCBjMjJiNDA4MCBjNWQ2YTJhMCBjMDNkNjIxYyBmZmZmZmYyOSANCkp1bCAyMyAxNjoyNjozNyBs
YWtldmlsbGUtZncga2VybmVsOiAgICAgICAgMDAwMDAwMDAgYzVkNmEyZjAgYzIyYjQwODAgMDg2
NzYwMDAgMDAwMDAwMDAgY2Q2NjhlN2MgYzJjMWE0ZWMgYzVkNmEyYTAgDQpKdWwgMjMgMTY6MjY6
MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogQ2FsbCBUcmFjZToNCkp1bCAyMyAxNjoyNjozNyBsYWtl
dmlsbGUtZncga2VybmVsOiAgPGMwMTQ5MTA5PiBmcmVlX3BhZ2VfYW5kX3N3YXBfY2FjaGUrMHgx
Yi8weDJhICA8YzAxNDI2NDU+IHVubWFwX3ZtYXMrMHgyOTcvMHg0OTANCkp1bCAyMyAxNjoyNjoz
NyBsYWtldmlsbGUtZncga2VybmVsOiAgPGMwMTQ0ZGRkPiBleGl0X21tYXArMHg1MC8weGJjICA8
YzAxMTgxNGU+IG1tcHV0KzB4MWYvMHg3Ng0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBr
ZXJuZWw6ICA8YzAxMWM1ZDc+IGRvX2V4aXQrMHgxOGEvMHg2Y2EgIDxjMDExY2I4ND4gc3lzX2V4
aXRfZ3JvdXArMHgwLzB4ZA0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6ICA8
YzAxMjM2M2U+IGdldF9zaWduYWxfdG9fZGVsaXZlcisweDM0Ny8weDM4YiAgPGMwMTAyMWJlPiBk
b19ub3RpZnlfcmVzdW1lKzB4NmYvMHg1YjgNCkp1bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncg
a2VybmVsOiAgPGMwMmNjN2U1PiB1bml4X2lvY3RsKzB4YTMvMHhhYyAgPGMwMmQyZmE1PiBfc3Bp
bl91bmxvY2tfaXJxKzB4NS8weDcNCkp1bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncga2VybmVs
OiAgPGMwMmQxZGI0PiBzY2hlZHVsZSsweDQ5ZS8weDRmYSAgPGMwMTAyYWU2PiB3b3JrX25vdGlm
eXNpZysweDEzLzB4MTkNCkp1bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncga2VybmVsOiBDb2Rl
OiAwYiA4YiA0OCAxNCA4NSBjOSA3NCAwNCA4OSBkYSBmZiBkMSBiOCA0MCA5OSAzMyBjMCA4MyBj
YSBmZiAwZiBjMSAxMCAwZiA4OCBiMSAxNCAwMCAwMCA1Yg0KIDVlIGMzIDU2IDUzIDg5IGMzIDhi
IDAwIGY2IGM0IDA4IDc0IDA4IDwwZj4gMGIgNjAgMDEgYmYgMmIgMmYgYzAgOGIgMDMgYTggMDEg
NzUgMDggMGYgMGIgNjEgMDEgYmYgMmIgMmYgDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3
IGtlcm5lbDogRUlQOiBbPGMwMTQ5Yzk0Pl0gcmVtb3ZlX2V4Y2x1c2l2ZV9zd2FwX3BhZ2UrMHhi
LzB4ZTMgU1M6RVNQIDAwNjg6Y2Q2NjhlMDQNCkp1bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncg
a2VybmVsOiAgPDM+QlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNv
bnRleHQgYXQgaW5jbHVkZS9saW51eC9yd3NlbS5oOjQzDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZp
bGxlLWZ3IGtlcm5lbDogaW5fYXRvbWljKCk6MSwgaXJxc19kaXNhYmxlZCgpOjANCkp1bCAyMyAx
NjoyNjozNyBsYWtldmlsbGUtZncga2VybmVsOiAgPGMwMTI0MzFkPiBibG9ja2luZ19ub3RpZmll
cl9jYWxsX2NoYWluKzB4MTgvMHg0OSAgPGMwMTFjNDY5PiBkb19leGl0KzB4MWMvMHg2Y2ENCkp1
bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncga2VybmVsOiAgPGMwMTAzZDA4PiBkaWUrMHgxYWYv
MHgyNjQgIDxjMDEwM2Q5OD4gZGllKzB4MjNmLzB4MjY0DQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZp
bGxlLWZ3IGtlcm5lbDogIDxjMDEwNDMyOT4gZG9faW52YWxpZF9vcCsweDAvMHg5ZCAgPGMwMTA0
M2JhPiBkb19pbnZhbGlkX29wKzB4OTEvMHg5ZA0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1m
dyBrZXJuZWw6ICA8YzAxNDljOTQ+IHJlbW92ZV9leGNsdXNpdmVfc3dhcF9wYWdlKzB4Yi8weGUz
ICA8YzAxMTY5NDM+IHRyeV90b193YWtlX3VwKzB4ZTkvMHhmMw0KSnVsIDIzIDE2OjI2OjM3IGxh
a2V2aWxsZS1mdyBrZXJuZWw6ICA8YzAxMTY0NTM+IF9fd2FrZV91cF9jb21tb24rMHgyZi8weDUz
ICA8YzAxMTZhY2Y+IF9fd2FrZV91cCsweDJhLzB4M2QNCkp1bCAyMyAxNjoyNjozNyBsYWtldmls
bGUtZncga2VybmVsOiAgPGMwMTAzNTBmPiBlcnJvcl9jb2RlKzB4NGYvMHg1NCAgPGMwMTQ5Yzk0
PiByZW1vdmVfZXhjbHVzaXZlX3N3YXBfcGFnZSsweGIvMHhlMw0KSnVsIDIzIDE2OjI2OjM3IGxh
a2V2aWxsZS1mdyBrZXJuZWw6ICA8YzAxNDkxMDk+IGZyZWVfcGFnZV9hbmRfc3dhcF9jYWNoZSsw
eDFiLzB4MmEgIDxjMDE0MjY0NT4gdW5tYXBfdm1hcysweDI5Ny8weDQ5MA0KSnVsIDIzIDE2OjI2
OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6ICA8YzAxNDRkZGQ+IGV4aXRfbW1hcCsweDUwLzB4YmMg
IDxjMDExODE0ZT4gbW1wdXQrMHgxZi8weDc2DQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3
IGtlcm5lbDogIDxjMDExYzVkNz4gZG9fZXhpdCsweDE4YS8weDZjYSAgPGMwMTFjYjg0PiBzeXNf
ZXhpdF9ncm91cCsweDAvMHhkDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDog
IDxjMDEyMzYzZT4gZ2V0X3NpZ25hbF90b19kZWxpdmVyKzB4MzQ3LzB4MzhiICA8YzAxMDIxYmU+
IGRvX25vdGlmeV9yZXN1bWUrMHg2Zi8weDViOA0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1m
dyBrZXJuZWw6ICA8YzAyY2M3ZTU+IHVuaXhfaW9jdGwrMHhhMy8weGFjICA8YzAyZDJmYTU+IF9z
cGluX3VubG9ja19pcnErMHg1LzB4Nw0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJu
ZWw6ICA8YzAyZDFkYjQ+IHNjaGVkdWxlKzB4NDllLzB4NGZhICA8YzAxMDJhZTY+IHdvcmtfbm90
aWZ5c2lnKzB4MTMvMHgxOQ0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6IEZp
eGluZyByZWN1cnNpdmUgZmF1bHQgYnV0IHJlYm9vdCBpcyBuZWVkZWQhDQpKdWwgMjMgMTY6MjY6
MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogQlVHOiBzY2hlZHVsaW5nIHdoaWxlIGF0b21pYzogZmxv
YXRlcnMvMHgwMDAwMDAwMS80ODc1DQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3IGtlcm5l
bDogIDxjMDJkMTk1OT4gc2NoZWR1bGUrMHg0My8weDRmYSAgPGMwMWI4OWE0PiBjZnFfZnJlZV9p
b19jb250ZXh0KzB4MmEvMHg1NA0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6
ICA8YzAxMWM1MTg+IGRvX2V4aXQrMHhjYi8weDZjYSAgPGMwMTAzZDA4PiBkaWUrMHgxYWYvMHgy
NjQNCkp1bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncga2VybmVsOiAgPGMwMTAzZDk4PiBkaWUr
MHgyM2YvMHgyNjQgIDxjMDEwNDMyOT4gZG9faW52YWxpZF9vcCsweDAvMHg5ZA0KSnVsIDIzIDE2
OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6ICA8YzAxMDQzYmE+IGRvX2ludmFsaWRfb3ArMHg5
MS8weDlkICA8YzAxNDljOTQ+IHJlbW92ZV9leGNsdXNpdmVfc3dhcF9wYWdlKzB4Yi8weGUzDQpK
dWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogIDxjMDExNjk0Mz4gdHJ5X3RvX3dh
a2VfdXArMHhlOS8weGYzICA8YzAxMTY0NTM+IF9fd2FrZV91cF9jb21tb24rMHgyZi8weDUzDQpK
dWwgMjMgMTY6MjY6MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogIDxjMDExNmFjZj4gX193YWtlX3Vw
KzB4MmEvMHgzZCAgPGMwMTAzNTBmPiBlcnJvcl9jb2RlKzB4NGYvMHg1NA0KSnVsIDIzIDE2OjI2
OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6ICA8YzAxNDljOTQ+IHJlbW92ZV9leGNsdXNpdmVfc3dh
cF9wYWdlKzB4Yi8weGUzICA8YzAxNDkxMDk+IGZyZWVfcGFnZV9hbmRfc3dhcF9jYWNoZSsweDFi
LzB4MmENCkp1bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncga2VybmVsOiAgPGMwMTQyNjQ1PiB1
bm1hcF92bWFzKzB4Mjk3LzB4NDkwICA8YzAxNDRkZGQ+IGV4aXRfbW1hcCsweDUwLzB4YmMNCkp1
bCAyMyAxNjoyNjozNyBsYWtldmlsbGUtZncga2VybmVsOiAgPGMwMTE4MTRlPiBtbXB1dCsweDFm
LzB4NzYgIDxjMDExYzVkNz4gZG9fZXhpdCsweDE4YS8weDZjYQ0KSnVsIDIzIDE2OjI2OjM3IGxh
a2V2aWxsZS1mdyBrZXJuZWw6ICA8YzAxMWNiODQ+IHN5c19leGl0X2dyb3VwKzB4MC8weGQgIDxj
MDEyMzYzZT4gZ2V0X3NpZ25hbF90b19kZWxpdmVyKzB4MzQ3LzB4MzhiDQpKdWwgMjMgMTY6MjY6
MzcgbGFrZXZpbGxlLWZ3IGtlcm5lbDogIDxjMDEwMjFiZT4gZG9fbm90aWZ5X3Jlc3VtZSsweDZm
LzB4NWI4ICA8YzAyY2M3ZTU+IHVuaXhfaW9jdGwrMHhhMy8weGFjDQpKdWwgMjMgMTY6MjY6Mzcg
bGFrZXZpbGxlLWZ3IGtlcm5lbDogIDxjMDJkMmZhNT4gX3NwaW5fdW5sb2NrX2lycSsweDUvMHg3
ICA8YzAyZDFkYjQ+IHNjaGVkdWxlKzB4NDllLzB4NGZhDQpKdWwgMjMgMTY6MjY6MzcgbGFrZXZp
bGxlLWZ3IGtlcm5lbDogIDxjMDEwMmFlNj4gd29ya19ub3RpZnlzaWcrMHgxMy8weDE5IA0KSnVs
IDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6IGF1ZGl0KDExNTM2ODk5OTcuNDE2OjI0
KTogYXZjOiAgZGVuaWVkICB7IHdyaXRlIH0gZm9yICBwaWQ9NDkxNiBjb21tPSJzeXNsb2dkIiBu
YW1lPSIzIiBkZXY9ZGV2DQpwdHMgaW5vPTUgc2NvbnRleHQ9c3lzdGVtX3U6c3lzdGVtX3I6c3lz
bG9nZF90OnMwIHRjb250ZXh0PXVzZXJfdTpvYmplY3Rfcjp0ZWxuZXRkX2RldnB0c190OnMwIHRj
bGFzcz1jaHJfZmlsZQ0KSnVsIDIzIDE2OjI2OjM3IGxha2V2aWxsZS1mdyBrZXJuZWw6IGF1ZGl0
KDExNTM2ODk5OTcuNDE2OjI1KTogYXZjOiAgZGVuaWVkICB7IGdldGF0dHIgfSBmb3IgIHBpZD00
OTE2IGNvbW09InN5c2xvZ2QiIG5hbWU9IjMiIGRldj1kDQpldnB0cyBpbm89NSBzY29udGV4dD1z
eXN0ZW1fdTpzeXN0ZW1fcjpzeXNsb2dkX3Q6czAgdGNvbnRleHQ9dXNlcl91Om9iamVjdF9yOnRl
bG5ldGRfZGV2cHRzX3Q6czAgdGNsYXNzPWNocl9maWxl

------_=_NextPart_001_01C6AEB9.7E1E0D38--
