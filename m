Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422993AbWJQAqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993AbWJQAqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422997AbWJQAqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:46:03 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:28079 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1422993AbWJQAqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:46:01 -0400
Date: Mon, 16 Oct 2006 20:44:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: raw1394 problems galore
In-reply-to: <4533FBD8.7050101@s5r6.in-berlin.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: For users of Fedora Core releases <fedora-list@redhat.com>,
       linux-kernel@vger.kernel.org, linux1394-user@lists.sourceforge.net
Reply-to: For users of Fedora Core releases <fedora-list@redhat.com>
Message-id: <45342789.2050506@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <4532DF11.9060704@verizon.net> <4533B889.5060302@s5r6.in-berlin.de>
 <4533DDA2.2050008@verizon.net> <4533FBD8.7050101@s5r6.in-berlin.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Gene Heskett wrote:

[...]

>> There should be a message like "ieee1394: Host added: ID:BUS[0-00:1023]
>>  GUID..." shortly later. It's logged at kern.debug level though.

 >I had udev set for debug earlier, lemme check the older log.

 >In logs reaching back 8 days while I messed with this, the string
 >"ieee1394: Host added: ID:BUS" never appears.

>> Then, manually loaded via 'modprobe raw1394':
>>
>> Oct 16 11:50:11 diablo kernel: ieee1394: raw1394: /dev/raw1394 device
>> initialized

But there are lots of the above, and hundreds of:
Oct 15 19:47:32 diablo udevd[417]: udev_event_run: seq 775 forked, pid
[2645], 'add' 'ieee1394', 0 seconds old
Oct 15 19:47:32 diablo udevd[417]: udev_event_run: seq 777 forked, pid
[2646], 'add' 'ieee1394', 0 seconds old
Oct 15 19:47:32 diablo udevd-event[2645]: wait_for_sysfs: file
'/sys/devices/pci0000:00/0000:00:14.4/0000:03:04.2/fw-host0/08004601044684e4/bus
' appeared after 0 loops
Oct 15 19:47:32 diablo udevd-event[2645]: pass_env_to_socket: passed -1
bytes to socket '/org/kernel/udev/monitor',
Oct 15 19:47:32 diablo udevd-event[2645]: run_program:
'/lib/udev/udev_run_hotplugd'
Oct 15 19:47:32 diablo udevd-event[2645]: run_program:
'/lib/udev/udev_run_hotplugd' returned with status 0
Oct 15 19:47:32 diablo udevd-event[2645]: run_program:
'/lib/udev/udev_run_devd'
Oct 15 19:47:32 diablo udevd-event[2645]: run_program:
'/lib/udev/udev_run_devd' returned with status 0
Oct 15 19:47:32 diablo udevd-event[2645]: pass_env_to_socket: passed 242
bytes to socket '/org/freedesktop/hal/udev_event',
Oct 15 19:47:32 diablo udevd-event[2645]: udev_event_run: seq 775 finished
Oct 15 19:47:32 diablo udevd[417]: udev_done: seq 775, pid [2645] exit
with 0, 0 seconds old
Oct 15 19:47:32 diablo udevd-event[2646]: wait_for_sysfs: file
'/sys/devices/pci0000:00/0000:00:14.4/0000:03:04.2/fw-host0/623f0200cbe5407d/bus
' appeared after 0 loops
Oct 15 19:47:32 diablo udevd[417]: udev_event_run: seq 776 forked, pid
[2649], 'add' 'ieee1394_node', 0 seconds old
Oct 15 19:47:32 diablo udevd-event[2646]: pass_env_to_socket: passed -1
bytes to socket '/org/kernel/udev/monitor',
Oct 15 19:47:32 diablo udevd-event[2646]: run_program:
'/lib/udev/udev_run_hotplugd'
Oct 15 19:47:32 diablo udevd-event[2649]: pass_env_to_socket: passed -1
bytes to socket '/org/kernel/udev/monitor',
Oct 15 19:47:32 diablo udevd-event[2646]: run_program:
'/lib/udev/udev_run_hotplugd' returned with status 0
Oct 15 19:47:32 diablo udevd-event[2649]: run_program:
'/lib/udev/udev_run_hotplugd'
Oct 15 19:47:32 diablo udevd-event[2646]: run_program:
'/lib/udev/udev_run_devd'
Oct 15 19:47:32 diablo udevd[417]: udev_event_run: seq 779 forked, pid
[2651], 'add' 'ieee1394', 0 seconds old
Oct 15 19:47:32 diablo udevd-event[2651]: wait_for_sysfs: file
'/sys/devices/pci0000:00/0000:00:14.4/0000:03:04.2/fw-host0/08004601044684e4/080
04601044684e4-0/bus' appeared after 0 loops



> OK.
> 
>> Oct 16 11:50:11 diablo kernel: audit(1161013811.874:4): avc:  denied  {
>> getattr } for  pid=2753 comm="pam_console_app" name="raw1394" dev=tmpfs
>>  ino=10625 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
>> tcontext=system_u:object_r:device_t:s0 tclass=chr_file
>> Oct 16 11:50:11 diablo kernel: audit(1161013811.874:5): avc:  denied  {
>> setattr } for  pid=2753 comm="pam_console_app" name="raw1394" dev=tmpfs
>>  ino=10625 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
>> tcontext=system_u:object_r:device_t:s0 tclass=chr_file
> 
> I don't get what this is about. Who denies what?
> 
It just says denied, but selinux is set permissive, so thats just a
report of what would be denied if it was fully enabled.

>> SELinux is in permissive mode, and /dev/raw1394 has perms of:
>> [root@diablo ~]# ls -l /dev/raw1394
>> crw-rw-rw- 1 root root 171, 0 Oct 16 11:50 /dev/raw1394
>>
>> As I had given up, the camera is packed away, but I'll get it out and
>> connect it again for grins:
>>
>> And no further messages were logged when I plugged it in and turned it on.
> 
> There should be something like "ieee1394: Node added: ID:BUS[0-00:1023]
>  GUID..." and that the host changed from 0-00 to 1-00 at kern.debug level.

Never happens.

> 
>> kino-0.8 receives video from it in real time and is doing so right now,
>> and can capture it to file, and then play/edit that file, or could
>> saturday when I last tried it.  I ASSume that kino-0.9.2 could also
>> play/edit that file, but have not verified that by reinstalling 0.9.2.
> ...
>>> Did you run FC2 as 32bit environment on 32bit kernel?
>> Yes, and kino-0.7.5 died with kernel changes in the ieee1394 code
>> someplace at about 2.6.9 IIRC.
> ...
>>>> before someone just had to rewrite the 1394 stuff again?
>>> The 1394 kernel drivers are not being rewritten.
>> I was told it was a total rewrite of bad code when I complained about a
>> year ago.  My reply at the time was that it worked, and I don't often
>> fix things that are working.  I'm getting lazy in my dotage I guess.
> 
> I don't remember what was changed at that time. Maybe that was the
> addition of the new isochronous interface that I mentioned. The old one
> was (is?) still there but maybe there were interactions... However this
> is not related to the inability to issue AV/C commands, which are issued
> asynchronously. I think though that your kino 0.8.x package is
> configured to work isochronously via video1394(?)

Its showing raw1394, the other choice is dvgrab, which doesn't...

  but asynchronously via
> raw1394, and the kino 0.9.x package to do both via raw1394. But don't
> take my word on it, I keep mistaking one interface for another. I never
> used video cameras on FireWire myself.
> 
>> As for 1394commander or gscanbus, I have not managed to find rpms of
>> those in any of the repos yumex or SPM shows me.  They apparently are
>> not part of the FC5 tree.  I'd love to see what those 2 might have to
>> say about the system.  The only thing I do have is dvcont, which reports
>> this:
>>
>> [root@diablo ~]# dvcont dev 0 play
>> Could not find any AV/C devices on the 1394 bus.
>>
>> The camera is still plugged in and powered up.
> 
> Anything under /sys/bus/ieee1394/devices?
[root@diablo ~]# ls -R /sys/bus/ieee1394/devices
/sys/bus/ieee1394/devices:
08004601044684e4  08004601044684e4-0  623f0200cbe5407d
623f0200cbe5407d-0  fw-host0

and:
[root@diablo ~]# ls -l /sys/bus/ieee1394/devices/fw-host0
lrwxrwxrwx 1 root root 0 Oct 16 11:16 /sys/bus/ieee1394/devices/fw-host0
-> ../../../devices/pci0000:00/0000:00:14.4/0000:03:04.2/fw-host0
[root@diablo ~]#
> 
> It might be not too difficult to compile 1394commander since it doesn't
> have many library dependencies; just libraw1394 (probably as -devel
> package) and optionally readline. Gscanbus would show a bit more about
> attached devices without resorting to magic commands but it is a bit
> harder to compile, as a GUI program.

I'll put in the devel stuff and give it a shot.  And let the lists know.

I did find, with googles help, some rpms of 1394commander and gscanbus, 
but they don't work here.

gscanbus bus displays two icons, one for the device (ohci1394) running 
at 400megabaud, and the camera running at 100 megabaud.  Clicking on 
either icon locks it, but it does respond to a ctl+c in the shell the 
launched it.

And 1394commander has problems with my readline library I think:
[root@diablo src]# 1394commander
1394commander: symbol lookup error: /usr/lib/libreadline.so.5:

I believe its way too long in the tooth for modern 1394 snooping as its 
3 years old or more.

I tried to build the src rpm of gscanbus, but it autoedits gscanbus.c, 
wrapping long lines which then fail to compile due to missing final " in 
a 2+ line text argument.  Its there, but the compiler apparently expects 
to see the ending " on the same line as opposed to 2-3 lines below.

Thanks, Stefan

-- 
Cheers, Gene

-- 
fedora-list mailing list
fedora-list@redhat.com
To unsubscribe: https://www.redhat.com/mailman/listinfo/fedora-list

