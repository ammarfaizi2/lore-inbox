Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268171AbTGTUJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268201AbTGTUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:09:57 -0400
Received: from main.gmane.org ([80.91.224.249]:31406 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268171AbTGTUJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:09:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6-test1 startup messages?
Date: Sun, 20 Jul 2003 22:22:46 +0200
Message-ID: <yw1xbrvpuew9.fsf@users.sourceforge.net>
References: <20030720140035.GC20163@rdlg.net> <3F1AD2AA.9010603@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:jLs01i1gacq9c9ZJKyNjuZDFqXM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Gyurdiev <ivg2@cornell.edu> writes:

>>   I just converted a box to 2.6-test1.  I've installed the
>> module-init-tools
>> per another thread on the list.  Spread throughout the startup messages
>> of the system (Debian Unstable) are messages that read:
>> FATAL: Module /dev/tts not found
>> FATAL: Module /dev/tts not found
>> FATAL: Module /dev/ttsS?? not found
>> FATAL: Module /dev/ttsS?? not found
>> looking at /dev/tty* I have /dev/tty, /dev/tty0-tty63.  There is no
>> /dev/ttyS0 (serial console) or tts*.
>>
>
> Are you using devfs?
> I get the same messages with devfs.
> Looking up a /dev file that does not presently exist
> or have a corresponding module results in the above warnings.
> At boot time, on a redhat distro pam_console_apply tries to lookup
> the devices specified in /etc/security/console.perms, which causes a
> zillion warnings for me. The question is - are those warnings to
> correct way to handle a devfs lookup of a nonexisting device. I don't
> remember getting warnings under 2.4. Maybe I did, and just didn't
> notice (but I doubt it). They're certainly annoying and I don't like
> them.

It's the new modprobe that complains louder than the old one.  I guess
it's trivial to remove the printout from the source code.

-- 
Måns Rullgård
mru@users.sf.net

