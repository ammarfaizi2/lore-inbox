Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUGAMf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUGAMf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUGAMf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:35:59 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:40488 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S264770AbUGAMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:35:49 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Thu, 1 Jul 2004 14:34:57 +0200
User-Agent: KMail/1.6
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040630132305.98864.qmail@web81306.mail.yahoo.com>
In-Reply-To: <20040630132305.98864.qmail@web81306.mail.yahoo.com>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yTA5AehEAA+MDAA"
Message-Id: <200407011434.59340.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 01 Jul 2004 12:35:15.0124 (UTC) FILETIME=[DC0BAF40:01C45F67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yTA5AehEAA+MDAA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dmitry: On synaptics page, I've seen that you've got tons of bugfixes for 
2.6.7 on http://www.geocities.com/dt_or/input/2_6_7. Do I need something from 
there and is there a patch that contains all patches?


Sorry, I was in a hurry and forgot to attach the new kernel log file in my 
last mail. It is in the attachment, a log with the second patch you sent me.
The patch is installed in messages-noacpi and ACPI disabled.
 -> Why is the trace now so small? Did you disable DEBUG in your patch?
    ...oh yes! Then I'll have to recompile and retry...


Also I deinstalled the Powermanagement and ACPI in kernel configuration, as 
suggested by Pavlik. Result is:
No, it still does not work, problem No. 3/4 reproduced, the powermanagement is 
not the problem (see messages-noacpi)!


Am Mittwoch, 30. Juni 2004 15.23 schrieb Dmitry Torokhov unter "RE: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> > Am Mittwoch, 30. Juni 2004 08.02 schrieb Dmitry Torokhov unter "Re:
> > Continue:
> >
> > psmouse.c - synaptics touchpad driver sync problem":
> > > The mux got confused as to where the byte came from. They byte itself
> > > seems to be in line with other data in the stream. At this moment your
> > > mouse has probably started jumping around. The patch I send earlier
> > > should help with this kind of problem.
> >
> > Well, there are several things:
> >  1) Cursor hangs on system load with internal mousepad
> >     (no external mouse connected)
>
> You mean when the system load is high? Yes, that can happen..

System load does not have to be really high, so it happens quite often. This 
is very disturbing, like in MacOS 15 years ago! (That was one of the main 
reasons for me not to use Mac, besides the fact that an application could 
crash the whole system!) I think we now have a multitasking OS, haven't 
we?!? :-(

It is sometimes better, sometimes worse, but not really depending on system 
load, it seems. Just a minute ago it was really bad. Strange.


> >  2) Cursor jumps a bit with internal mousepad
> >     (no external mouse connected)
> >  3) Cursor jumps like crazy when moving external mouse
> >  4) Cursor randomly clicks when moving external mouse
>
> Has the external mouse ever worked in 2.6? Or is it always
> just randomly clickng stuff? Have you tried connecting another
> mouse?

No and yes. At home I have a wheel mouse, at work a normal PS/2 mouse, both 
with diffrent keyboards and both with the same problem. I never successfully 
used an external mouse since I upgraded to SuSE 9.1 (Kernel 2.6). I had no 
problems with kernel 2.4 and the same hardware.


> >  5) Hitting the mouse pad does not do a button1-click
>
> I gather you do not have the X Synaptis driver installed?
> Check out http://w1.894.telia.com/~u89404340/touchpad/index.html

I see. I'll try the tool. In kernel 2.4, no addidional driver was necessary, 
it always worked out of the box.

Isn't there an apt4rpm repository for SuSE 9.1 with these tools anywhere? 
Obviously not in the repositories of my sources.list. :-(

Pavlik: You work for SuSE? If synaptics is so vital for a touchpad to  work, 
why aren't tools and driver installed and configured by SuSE 9.1 per default? 
It is even not part of the distribution!?!


> >  6) Sometimes the keyboard does not work anymore or
> >     sends neverending random events - even with no
> >     external mouse/keyboard
> >
> > I did not recognize that the previous patch helped in any of these
> > problems, but No. 2 is the hardest to check, because I have to work
> > for a while until it occurs.
> >
> > The second patch does not help either.
> >
> > The i8042.nodemux option only "resolved" No. 3 and No. 4, because the
> > external mouse was no more available. Until now, nothing makes anything
> > better.
>
> Just to confirm - you are saying that the touchpad + external mouse
> worked together fine in 2.4 but in 2.6 with i8042.nomux the external
> mouse does not work, correct?

Yes, I had none of all six problems in 2.4.

For i8042.nomux, I check it again, just to be sure...
...yes, the external keyboard works, but not the external mouse


> > > It seems that we are missing a byte between ff and 18, delay between 2
> > > bytes is about a second... Where did the byte go? Do you have DMA
> > > turned on on your hard driver? Anything polling battery status? Can't
> > > do anything here...
> >
> > Do you mean hard disk DMA? Then Yes for DMA and yes for polling.
>
> Ok, what program does the polling? What is the polling interval? Does
> it help if you stop the program?

I don't really know how many daemons are polling. On the desktop, I run 
kpowersave and I configured powersaving so that it should shotdown before 
battery is ampty, so there must be a daemon polling. It's just configure with 
normal KDE/YaST powersaving controls.


Regards
Marc

--Boundary-00=_yTA5AehEAA+MDAA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="messages-noacpi"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="messages-noacpi"

Jul  1 12:36:24 qingwa syslogd 1.4.1: restart.
Jul  1 12:36:24 qingwa hcid[1994]: HCI daemon ver 2.4 started
Jul  1 12:36:25 qingwa sdpd[2005]: sdpd v1.5 started=20
Jul  1 12:36:27 qingwa rcpowersaved: INFO: Your system does neither support=
 ACPI nor APM. the powersave service does not provide any features for this=
 machine, therefore the service is skipped.
Jul  1 12:36:28 qingwa rcpowersaved: CPU frequency scaling is not supported=
 by your processor.
Jul  1 12:36:28 qingwa rcpowersaved: enter 'POWERSAVE_CPUFREQD_MODULE=3Doff=
' in /etc/sysconfig/powersave/common to avoid this warning.
Jul  1 12:36:28 qingwa [powersaved][2145]: ERROR in Function checkACPI; lin=
e 30: Neither APM nor ACPI is supported!
Jul  1 12:36:28 qingwa sshd[2202]: Server listening on :: port 22.
Jul  1 12:36:29 qingwa kernel: klogd 1.4.1, log source =3D /proc/kmsg start=
ed.
Jul  1 12:36:29 qingwa kernel: Inspecting /boot/System.map-2.6.7
Jul  1 12:36:29 qingwa kernel: Loaded 27761 symbols from /boot/System.map-2=
=2E6.7.
Jul  1 12:36:29 qingwa kernel: Symbols match kernel version 2.6.7.
Jul  1 12:36:29 qingwa kernel: No module symbols loaded - kernel modules no=
t enabled.=20
Jul  1 12:36:29 qingwa kernel: XFS mounting filesystem loop0
Jul  1 12:36:29 qingwa kernel: Ending clean XFS mount for filesystem: loop0
Jul  1 12:36:29 qingwa kernel: Linux Kernel Card Services
Jul  1 12:36:29 qingwa kernel:   options:  [pci] [cardbus]
Jul  1 12:36:29 qingwa kernel: PCI: Found IRQ 11 for device 0000:00:03.0
Jul  1 12:36:29 qingwa kernel: PCI: Sharing IRQ 11 with 0000:00:01.4
Jul  1 12:36:29 qingwa kernel: Yenta: CardBus bridge found at 0000:00:03.0 =
[1584:3000]
Jul  1 12:36:29 qingwa kernel: Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Jul  1 12:36:29 qingwa kernel: Socket status: 30000821
Jul  1 12:36:29 qingwa kernel: Bluetooth: Core ver 2.5
Jul  1 12:36:29 qingwa kernel: NET: Registered protocol family 31
Jul  1 12:36:29 qingwa kernel: Bluetooth: HCI device and connection manager=
 initialized
Jul  1 12:36:29 qingwa kernel: Bluetooth: HCI socket layer initialized
Jul  1 12:36:29 qingwa kernel: Bluetooth: HCI USB driver ver 2.6
Jul  1 12:36:29 qingwa kernel: usbcore: registered new driver hci_usb
Jul  1 12:36:29 qingwa kernel: Bluetooth: HCI UART driver ver 2.1
Jul  1 12:36:29 qingwa kernel: Bluetooth: HCI H4 protocol initialized
Jul  1 12:36:29 qingwa kernel: Bluetooth: HCI BCSP protocol initialized
Jul  1 12:36:29 qingwa kernel: Bluetooth: VHCI driver ver 1.1
Jul  1 12:36:29 qingwa kernel: Bluetooth: L2CAP ver 2.2
Jul  1 12:36:29 qingwa kernel: Bluetooth: L2CAP socket layer initialized
Jul  1 12:36:29 qingwa kernel: NET: Registered protocol family 10
Jul  1 12:36:29 qingwa kernel: Disabled Privacy Extensions on device c0343c=
40(lo)
Jul  1 12:36:29 qingwa kernel: IPv6 over IPv4 tunneling driver
Jul  1 12:36:29 qingwa kernel: Disabled Privacy Extensions on device c9f650=
00(sit0)
Jul  1 12:36:33 qingwa ifup: No configuration found for sit0
Jul  1 12:36:49 qingwa kernel: drivers/usb/serial/usb-serial.c: USB Serial =
support registered for Generic
Jul  1 12:36:49 qingwa kernel: usbcore: registered new driver usbserial
Jul  1 12:36:49 qingwa kernel: drivers/usb/serial/usb-serial.c: USB Serial =
Driver core v2.0
Jul  1 12:36:58 qingwa /usr/sbin/cron[7758]: (CRON) STARTUP (fork ok)=20
Jul  1 12:36:59 qingwa kernel: Non-volatile memory driver v1.2
Jul  1 12:37:00 qingwa kernel: end_request: I/O error, dev fd0, sector 0
Jul  1 12:37:00 qingwa kernel: end_request: I/O error, dev fd0, sector 0
Jul  1 12:37:00 qingwa kernel: hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Jul  1 12:37:00 qingwa kernel: Uniform CD-ROM driver Revision: 3.20
Jul  1 12:37:00 qingwa /etc/hotplug/block.agent[7835]: grep: /sys/class/scs=
i_host/ide1/proc_name: No such file or directory
Jul  1 12:37:00 qingwa /etc/hotplug/block.agent[7835]: grep: /sys/class/scs=
i_host/ide1/proc_name: No such file or directory
Jul  1 12:37:00 qingwa kernel: st: Version 20040403, fixed bufsize 32768, s=
/g segs 256
Jul  1 12:37:00 qingwa kernel: Attached scsi generic sg0 at scsi0, channel =
0, id 0, lun 0,  type 0
Jul  1 12:37:00 qingwa /etc/hotplug/block.agent[7835]: new block device /bl=
ock/hdc
Jul  1 12:37:01 qingwa kernel: BIOS EDD facility v0.15 2004-May-17, 1 devic=
es found
Jul  1 12:37:12 qingwa kernel: agpgart: Found an AGP 2.0 compliant device a=
t 0000:00:00.0.
Jul  1 12:37:12 qingwa kernel: agpgart: Putting AGP V2 device at 0000:00:00=
=2E0 into 4x mode
Jul  1 12:37:12 qingwa kernel: agpgart: Putting AGP V2 device at 0000:01:00=
=2E0 into 4x mode
Jul  1 12:37:14 qingwa kdm: :0[8104]: pam_unix2: session started for user m=
arc, service xdm-np=20
Jul  1 12:38:10 qingwa gconfd (marc-8863): (Version 2.4.0.1) wird gestartet=
, Prozesskennung 8863, Benutzer =C2=BBmarc=C2=AB
Jul  1 12:38:10 qingwa gconfd (marc-8863): Die Adresse =C2=BBxml:readonly:/=
etc/opt/gnome/gconf/gconf.xml.mandatory=C2=AB wurde an der Position 0 zu ei=
ner nur lesbaren Konfigurationsquelle aufgel=C3=B6st
Jul  1 12:38:10 qingwa gconfd (marc-8863): Die Adresse =C2=BBxml:readwrite:=
/home/marc/.gconf=C2=AB wurde an der Position 1 zu einer schreibbaren Konfi=
gurationsquelle aufgel=C3=B6st
Jul  1 12:38:10 qingwa gconfd (marc-8863): Die Adresse =C2=BBxml:readonly:/=
etc/opt/gnome/gconf/gconf.xml.defaults=C2=AB wurde an der Position 2 zu ein=
er nur lesbaren Konfigurationsquelle aufgel=C3=B6st
Jul  1 12:38:46 qingwa kernel: atkbd.c: Spurious ACK on isa0060/serio0. Som=
e program, like XFree86, might be trying access hardware directly.
Jul  1 12:38:46 qingwa kernel: input: PS/2 Logitech Mouse on isa0060/serio4
Jul  1 12:39:03 qingwa kernel: psmouse.c: Mouse at isa0060/serio4/input0 lo=
st synchronization, throwing 1 bytes away.
Jul  1 12:39:06 qingwa kernel: psmouse.c: Mouse at isa0060/serio4/input0 lo=
st synchronization, throwing 1 bytes away.
Jul  1 12:39:29 qingwa kernel: psmouse.c: Mouse at isa0060/serio4/input0 lo=
st synchronization, throwing 2 bytes away.

--Boundary-00=_yTA5AehEAA+MDAA--
