Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbTGTTUl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267844AbTGTTUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:20:41 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:7861 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267773AbTGTTUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:20:40 -0400
Message-ID: <3F1AD2AA.9010603@cornell.edu>
Date: Sun, 20 Jul 2003 13:34:34 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test1 startup messages?
References: <20030720140035.GC20163@rdlg.net>
In-Reply-To: <20030720140035.GC20163@rdlg.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:
> 
>   I just converted a box to 2.6-test1.  I've installed the module-init-tools
> per another thread on the list.  Spread throughout the startup messages
> of the system (Debian Unstable) are messages that read:
> 
> FATAL: Module /dev/tts not found
> FATAL: Module /dev/tts not found
> FATAL: Module /dev/ttsS?? not found
> FATAL: Module /dev/ttsS?? not found
> 
> looking at /dev/tty* I have /dev/tty, /dev/tty0-tty63.  There is no
> /dev/ttyS0 (serial console) or tts*.
>

Are you using devfs?
I get the same messages with devfs.
Looking up a /dev file that does not presently exist
or have a corresponding module results in the above warnings.
At boot time, on a redhat distro pam_console_apply tries to lookup
the devices specified in /etc/security/console.perms, which causes a 
zillion warnings for me. The question is - are those warnings to correct 
way to handle a devfs lookup of a nonexisting device. I don't remember 
getting warnings under 2.4. Maybe I did, and just didn't notice (but I 
doubt it). They're certainly annoying and I don't like them.

P.S. Not a kernel developer - just a tester :)



