Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273017AbRIITcx>; Sun, 9 Sep 2001 15:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273019AbRIITcn>; Sun, 9 Sep 2001 15:32:43 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:59657 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S273017AbRIITcj>; Sun, 9 Sep 2001 15:32:39 -0400
Message-ID: <3B9BC3A8.9FC4A802@osdlab.org>
Date: Sun, 09 Sep 2001 12:31:52 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Ruf <ruf@tik.ee.ethz.ch>
CC: Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: Re: proc_mkdir -> where is proc_rmdir ?
In-Reply-To: <20010909194137.B1968@tik.ee.ethz.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Ruf wrote:
> 
> Dear all,
> 
> I created some directories below /proc while a module got installed.
> When I de-install the module, I would like to remove these directories as
> well?
> 
> First, I remove the entries within the directory by remove_proc_entry().
> So, the directories are empty.  But when I try to remove the self-created
> directories with a similar call to remove_proc_entry(), nothing happens.

Is the target proc directory in use, such as mounted?

> So, I simply ask: is there somewhere a proc_rmdir() ?  If not, how do I
> need to call the remove_proc_entry() such that the directory gets removed?
> 
> Thanks for any help!

remove_proc_entry() is what the usb subsystem uses to remove its
main usb-fs directory (/proc/bus/usb), and it works.

That's also what the proc-fs example at
http://kernelnewbies.org/documents/kdoc/procfs-guide/example.html
uses.  See that document if you haven't already.

~Randy
