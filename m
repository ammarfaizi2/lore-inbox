Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbULOMMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbULOMMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 07:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbULOMMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 07:12:09 -0500
Received: from mail.outpost24.com ([212.214.12.146]:9945 "EHLO
	klippan.outpost24.com") by vger.kernel.org with ESMTP
	id S262342AbULOMLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 07:11:55 -0500
Message-ID: <41C029F7.7010405@outpost24.com>
Date: Wed, 15 Dec 2004 13:11:35 +0100
From: David Jacoby <dj@outpost24.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
References: <41BFF931.6030205@outpost24.com> <20041215.180839.93043538.yoshfuji@linux-ipv6.org> <41C024B0.4010009@outpost24.com> <200412151254.37612@WOLK> <41C0268B.2030708@outpost24.com> <20041215120418.GA9049@tufnell.lon1.poggs.net>
In-Reply-To: <20041215120418.GA9049@tufnell.lon1.poggs.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter!

Well as i said in an earlier mail im using the default 2.4.24 kernel 
that is shipped
with Slackware. And the patched kernel is an 2.6.9 kernel from kernel.org

I did an "ssh -vvv" against the same host with different kernel versions 
and here is the result:

user@autopisa:~$ diff ssh_new_kernel.log ssh_old_kernel.log > ssh_diff.log
user@autopisa:~$ cat ssh_diff.log

45,46c45,46
< debug2: dh_gen_key: priv key bits set: 129/256
< debug2: bits set: 510/1024
---
 > debug2: dh_gen_key: priv key bits set: 126/256
 > debug2: bits set: 512/1024
53c53
< debug2: bits set: 529/1024
---
 > debug2: bits set: 512/1024
94c94
< debug3: packet_send2: adding 64 (len 49 padlen 15 extra_pad 64)
---
 > debug3: packet_send2: adding 64 (len 57 padlen 7 extra_pad 64)
96,107c96,186
< debug1: Authentications that can continue: 
publickey,password,keyboard-interactive
< Permission denied, please try again.
< debug3: packet_send2: adding 64 (len 49 padlen 15 extra_pad 64)
< debug2: we sent a password packet, wait for reply
< debug1: Authentications that can continue: 
publickey,password,keyboard-interactive
< Permission denied, please try again.
< debug3: packet_send2: adding 64 (len 49 padlen 15 extra_pad 64)
< debug2: we sent a password packet, wait for reply
< debug1: Authentications that can continue: 
publickey,password,keyboard-interactive
< debug2: we did not send a packet, disable method
< debug1: No more authentication methods to try.
< Permission denied (publickey,password,keyboard-interactive).
---
 > debug1: Authentication succeeded (password).
 > debug2: fd 6 setting O_NONBLOCK
 > debug1: channel 0: new [client-session]
 > debug3: ssh_session2_open: channel_new: 0
 > debug2: channel 0: send open
 > debug1: Entering interactive session.
 > debug2: callback start
 > debug2: ssh_session2_setup: id 0
 > debug2: channel 0: request pty-req
 > debug3: tty_make_modes: ospeed 38400
 > debug3: tty_make_modes: ispeed 38400
 > debug3: tty_make_modes: 1 3
 > debug3: tty_make_modes: 2 28
 > debug3: tty_make_modes: 3 127
 > debug3: tty_make_modes: 4 21
 > debug3: tty_make_modes: 5 4
 > debug3: tty_make_modes: 6 0
 > debug3: tty_make_modes: 7 0
 > debug3: tty_make_modes: 8 17
 > debug3: tty_make_modes: 9 19
 > debug3: tty_make_modes: 10 26
 > debug3: tty_make_modes: 12 18
 > debug3: tty_make_modes: 13 23
 > debug3: tty_make_modes: 14 22
 > debug3: tty_make_modes: 18 15
 > debug3: tty_make_modes: 30 0
 > debug3: tty_make_modes: 31 0
 > debug3: tty_make_modes: 32 0
 > debug3: tty_make_modes: 33 0
 > debug3: tty_make_modes: 34 0
 > debug3: tty_make_modes: 35 0
 > debug3: tty_make_modes: 36 1
 > debug3: tty_make_modes: 37 0
 > debug3: tty_make_modes: 38 1
 > debug3: tty_make_modes: 39 0
 > debug3: tty_make_modes: 40 0
 > debug3: tty_make_modes: 41 0
 > debug3: tty_make_modes: 50 1
 > debug3: tty_make_modes: 51 1
 > debug3: tty_make_modes: 52 0
 > debug3: tty_make_modes: 53 1
 > debug3: tty_make_modes: 54 1
 > debug3: tty_make_modes: 55 1
 > debug3: tty_make_modes: 56 0
 > debug3: tty_make_modes: 57 0
 > debug3: tty_make_modes: 58 0
 > debug3: tty_make_modes: 59 1
 > debug3: tty_make_modes: 60 1
 > debug3: tty_make_modes: 61 1
 > debug3: tty_make_modes: 62 0
 > debug3: tty_make_modes: 70 1
 > debug3: tty_make_modes: 71 0
 > debug3: tty_make_modes: 72 1
 > debug3: tty_make_modes: 73 0
 > debug3: tty_make_modes: 74 0
 > debug3: tty_make_modes: 75 0
 > debug3: tty_make_modes: 90 1
 > debug3: tty_make_modes: 91 1
 > debug3: tty_make_modes: 92 0
 > debug3: tty_make_modes: 93 0
 > debug2: channel 0: request shell
 > debug2: fd 3 setting TCP_NODELAY
 > debug2: callback done
 > debug2: channel 0: open confirm rwindow 0 rmax 32768
 > debug2: channel 0: rcvd adjust 131072
 > debug2: channel 0: rcvd eof
 > debug2: channel 0: output open -> drain
 > debug2: channel 0: obuf empty
 > debug2: channel 0: close_write
 > debug2: channel 0: output drain -> closed
 > debug1: client_input_channel_req: channel 0 rtype exit-status reply 0
 > debug2: channel 0: rcvd close
 > debug2: channel 0: close_read
 > debug2: channel 0: input open -> closed
 > debug3: channel 0: will not send data after close
 > debug2: channel 0: almost dead
 > debug2: channel 0: gc: notify user
 > debug2: channel 0: gc: user detached
 > debug2: channel 0: send close
 > debug2: channel 0: is dead
 > debug2: channel 0: garbage collecting
 > debug1: channel 0: free: client-session, nchannels 1
 > debug3: channel 0: status: The following connections are open:
 >   #0 client-session (t4 r0 i3/0 o3/0 fd -1/-1)
 > debug3: channel 0: close_fds r -1 w -1 e 6
 > debug1: fd 2 clearing O_NONBLOCK
 > Connection to 192.168.200.1 closed.
 > debug1: Transferred: stdin 0, stdout 0, stderr 37 bytes in 1.3 seconds
 > debug1: Bytes per second: stdin 0.0, stdout 0.0, stderr 29.0
 > debug1: Exit status 0

The patch fucked something up, sorry for my language. Is there anyone 
else on
this list who has the patch installed?

//David



Peter Hicks wrote:

>On Wed, Dec 15, 2004 at 12:56:59PM +0100, David Jacoby wrote:
>
>  
>
>>Well it is, i booted on the old kernel and SSH worked perfect and then on
>>the new kernel with the patch i cant SSH, i dont even get an password
>>prompt. I tried to ssh to more than one host aswell, i also removed the
>>key in .known_hosts but it still doesnt work.
>>    
>>
>
>Compare the .config of the old and new kernels with 'diff' and check that
>nothing else at all was changed.  It is highly improbable that ssh uses IGMP
>functionality!
>
>
>Peter.
>
>  
>


-- 
Outpost24 AB

David Jacoby
Research & Development

Office: +46-455-612310
Mobile: +46-455-612311
(www.outpost24.com) (dj@outpost24.com) 

