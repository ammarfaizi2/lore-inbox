Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317551AbSGJRDR>; Wed, 10 Jul 2002 13:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSGJRDQ>; Wed, 10 Jul 2002 13:03:16 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:19135 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S317551AbSGJRDP>; Wed, 10 Jul 2002 13:03:15 -0400
Message-ID: <FBB5E93ACF0CD51188D20002A55CBC98024FC0@edeacnt101.eed.ericsson.se>
X-Sybari-Trust: 088f5913 7216406a e4ad19be 00000138
From: "Ronny Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 + autofs on SMP problems
Date: Wed, 10 Jul 2002 19:05:46 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C22834.08B0F360"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C22834.08B0F360
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,

when using autofs, /proc/mounts gets screwed up (please look at attachement - I hope outlook won't ruin it),
so entries are listed multiple times; to get rid of this, you have to unmount them in the correct order, multiple times.

I think, this is an SMP-Problem, as on ~100 UP machines it's running fine.

Stats:
-gcc 2.95.3
-kernel 2.4.18 + O(1) sched (with or without, the same)
-autofs v3 in kernel (had the same problem with v4 way back at ~2.4.14-16, so i backed to v3)
-/usr/sbin/automount-version 3.1.7
-Dual Xeon 500 with 3G ram (4G option set in kernel)
-mount 2.10r
-glibc 2.1.3
-Base RedHat 6.2 install

Rebooting to test kernel-autofsv4 at the moment not possible.
If you need further information, please say so.

Kind regards,

Ronny


------_=_NextPart_000_01C22834.08B0F360
Content-Type: application/octet-stream;
	name="mounts"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mounts"

/dev/root / ext2 rw 0 0=0A=
/proc /proc proc rw 0 0=0A=
/dev/ida/c0d0p2 /boot ext2 rw 0 0=0A=
/dev/ida/c0d0p6 /usr ext2 rw 0 0=0A=
/dev/ida/c0d0p7 /var ext2 rw 0 0=0A=
pts /dev/pts devpts rw 0 0=0A=
automount(pid549) /pkg autofs rw 0 0=0A=
automount(pid565) /proj autofs rw 0 0=0A=
eedn7ls-gw1,eedn7ls-gw2:/export/apps9/matlab/i386 /pkg/matlab nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn7ls-gw1 0 0=0A=
eedn18ls:/vol/vol4/proj_cat /proj/cat nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
automount(pid3321) /home autofs rw 0 0=0A=
automount(pid3360) /proj autofs rw 0 0=0A=
eedn18ls:/vol/vol1/home-rm/eedkre /home/eedkre nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn18ls:/vol/vol3/proj_dspdata /proj/dspdata nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
automount(pid4541) /home autofs rw 0 0=0A=
automount(pid4576) /proj autofs rw 0 0=0A=
eedn18ls:/vol/vol1/home-rm/eedkre /home/eedkre nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn18ls:/vol/vol3/proj_dspdata /proj/dspdata nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
automount(pid4765) /home autofs rw 0 0=0A=
automount(pid4805) /proj autofs rw 0 0=0A=
eedn18ls:/vol/vol1/home-rm/eedkre /home/eedkre nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn18ls:/vol/vol3/proj_dspdata /proj/dspdata nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
automount(pid6112) /home autofs rw 0 0=0A=
automount(pid6130) /pkg autofs rw 0 0=0A=
automount(pid6148) /proj autofs rw 0 0=0A=
eedn18ls:/vol/vol1/home-rm/eedkre /home/eedkre nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn18ls:/vol/vol3/proj_dspdata /proj/dspdata nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn274w:/opt/data /proj/dspdata_eedn274w nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn274w 0 0=0A=
eedn18ls:/vol/vol1/home-ra/eedmpa /home/eedmpa nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn7ls-gw1,eedn7ls-gw2:/export/apps9/matlab/i386 /pkg/matlab nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn7ls-gw1 0 0=0A=
eedn18ls:/vol/vol4/proj_watm /proj/watm nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
automount(pid15708) /home autofs rw 0 0=0A=
automount(pid15726) /pkg autofs rw 0 0=0A=
automount(pid15745) /proj autofs rw 0 0=0A=
automount(pid15764) /grp autofs rw 0 0=0A=
eedn18ls:/vol/vol1/home-rm/eedkre /home/eedkre nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn18ls:/vol/vol3/proj_dspdata /proj/dspdata nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn18ls 0 0=0A=
eedn13ls:/vol/vol2/home-i/eedrla /home/eedrla nfs =
rw,v3,rsize=3D4096,wsize=3D4096,soft,udp,lock,addr=3Deedn13ls 0 0=0A=

------_=_NextPart_000_01C22834.08B0F360--
