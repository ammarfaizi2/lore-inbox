Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSCXP4x>; Sun, 24 Mar 2002 10:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293635AbSCXP4n>; Sun, 24 Mar 2002 10:56:43 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:1570 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S293603AbSCXP4b>; Sun, 24 Mar 2002 10:56:31 -0500
Message-ID: <3C9DF7A4.5000502@mindspring.com>
Date: Sun, 24 Mar 2002 10:58:28 -0500
From: Chris Swiedler <ceswiedler@mindspring.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andreas <andihartmann@freenet.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <3C9DC1F5.6010508@athlon.maya.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andreas wrote:
> Hello all,
> 
> I've got a basic question:
> Would it be possible to kill only the process which consumes the most 
> memory in the last delta t?
> Or does somebody have a better idea?

I had a patch for 2.4.something which would allow you to configure which 
processes were killed first by the OOM killer. You basically gave 
processes an oom_nice value, either by pid or process name, and that was 
  taken into account by the oom killer. You could also protect a process 
completely from the oom killer, which would be good to do for your sshd 
process in the example you give.

Look at http://www.uwsg.iu.edu/hypermail/linux/kernel/0011.1/0453.html

chris

