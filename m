Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTDPN3N (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTDPN3N 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:29:13 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:48562 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S264357AbTDPN3M 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:29:12 -0400
Subject: Re: Private namespaces
From: Lee Causier <LeeCausier@GameBox.net>
To: Adrian Etchevarne <aetcheva@it.itba.edu.ar>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1052141040.355.12.camel@labunix>
References: <1052141040.355.12.camel@labunix>
Content-Type: text/plain
Organization: Internal Technical Support
Message-Id: <1050500415.4929.3.camel@kurta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Apr 2003 14:40:15 +0100
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.win.tue.nl/~aeb/linux/lk/lk-6.html

Take a look at 6.3.3 "Per-process namespaces"
[-- snip --]
"BUGS: The program mount does not know about this feature yet, so
updates /etc/mtab. Reality is visible in /proc/mounts. Some kernel
versions have a bug that would cause the new process to have a strange
working directory. Probably that is avoided if this is started with a
working directory / or so - not in some mounted filesystem."

I found symlinking /etc/mtab to /proc/self/mounts (or /proc/mounts,
mhich is a symlink to /proc/self/mounts) solved the mount bug.

HTH

Regards,

Lee Edward Causier.

On Mon, 2003-05-05 at 14:23, Adrian Etchevarne wrote:
> Hello,
> 	I've been looking for instructions to use private namespaces in Linux,
> without results. Can anyone tell where is the documentation about it?
> (I'm not refering to chroot(), but to /proc/<pid>/mounts). Or the proper
> files in the kernel sources?
> 
> Thanks,
> 	Adrian.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


