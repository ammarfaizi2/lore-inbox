Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRDWFS2>; Mon, 23 Apr 2001 01:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRDWFST>; Mon, 23 Apr 2001 01:18:19 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:25869 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131219AbRDWFSL>;
	Mon, 23 Apr 2001 01:18:11 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104230517.f3N5HqP214245@saturn.cs.uml.edu>
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
To: whitney@math.berkeley.edu
Date: Mon, 23 Apr 2001 01:17:52 -0400 (EDT)
Cc: manuel@mclure.org,
        kufel!ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        linux-kernel@vger.kernel.org
In-Reply-To: <200104230242.f3N2gns08877@adsl-209-76-109-63.dsl.snfc21.pacbell.net> from "Wayne Whitney" at Apr 22, 2001 07:42:49 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne writes:
> In mailing-lists.linux-kernel, Manuel A. McLure wrote:

>> Did you try nesting more than one "su -"? The first one after a boot
>> works for me - every other one fails.
>
> Same here: the first "su -" works OK, but a second nested one hangs:
>
>  8825 pts/2    S      0:00 /bin/su -
>  8826 pts/2    S      0:00 -bash
>  8854 pts/2    T      0:00 stty erase ?
>  8855 pts/0    R      0:00 ps ax

Try this:

ps -t pts/2 -o pid,ppid,pgid,sess,f,stat,ruid,euid,fname,nwchan,wchan
ps -t pts/2 s

(replace "pts/2" as needed to select the right tty, and split that
first one into two commands if it is too long)
