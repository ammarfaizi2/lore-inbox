Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUAGH5h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbUAGH5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:57:36 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:21929 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265221AbUAGH5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:57:06 -0500
Date: Wed, 7 Jan 2004 04:56:58 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.1-rc2 and samba 3.0.0 ( PANIC: internal error )
Message-Id: <20040107045658.593bf983.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20040107043519.67860bb5.vmlinuz386@yahoo.com.ar>
References: <20040107043519.67860bb5.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004 04:35:19 -0300, Gerardo Exequiel Pozzi wrote:
>Hi people,
>
>Ever since I updated to 2.6.1-rc2, they appear several messages in syslog.
>(Sorry i can't describe steps to reproduce it, but I suppose that it happens when the
>clients with win98 connect themselves, the connection is established and close the machine)
>This does not happen with the 2.6.0.

Ups, with 2.6.0 the same problem, but only one time. ( not so repeated as with 2.6.1-rc2 )


Jan  3 16:40:21 djgera smbd[27895]: [2004/01/03 16:40:21, 0] lib/fault.c:fault_report(36)
Jan  3 16:40:21 djgera smbd[27895]:   ===============================================================
Jan  3 16:40:21 djgera smbd[27895]: [2004/01/03 16:40:21, 0] lib/fault.c:fault_report(37)
Jan  3 16:40:21 djgera smbd[27895]:   INTERNAL ERROR: Signal 11 in pid 27895 (3.0.0)
Jan  3 16:40:21 djgera smbd[27895]:   Please read the appendix Bugs of the Samba HOWTO collection
Jan  3 16:40:21 djgera smbd[27895]: [2004/01/03 16:40:21, 0] lib/fault.c:fault_report(39)
Jan  3 16:40:21 djgera smbd[27895]:   ===============================================================
Jan  3 16:40:21 djgera smbd[27895]: [2004/01/03 16:40:21, 0] lib/util.c:smb_panic(1400)
Jan  3 16:40:21 djgera smbd[27895]:   PANIC: internal error
Jan  3 16:40:21 djgera smbd[27895]: [2004/01/03 16:40:21, 0] lib/util.c:smb_panic(1407)
Jan  3 16:40:21 djgera smbd[27895]:   BACKTRACE: 24 stack frames:
Jan  3 16:40:21 djgera smbd[27895]:    #0 /usr/sbin/smbd(smb_panic+0x1ea) [0x81efdba]
Jan  3 16:40:21 djgera smbd[27895]:    #1 /usr/sbin/smbd [0x81db0dd]
Jan  3 16:40:21 djgera smbd[27895]:    #2 /usr/sbin/smbd [0x81db141]
Jan  3 16:40:21 djgera smbd[27895]:    #3 /lib/libc.so.6 [0x40200018]
Jan  3 16:40:21 djgera smbd[27895]:    #4 /lib/libc.so.6 [0x4024b608]
Jan  3 16:40:21 djgera smbd[27895]:    #5 /lib/libc.so.6(malloc+0x93) [0x4024a803]
Jan  3 16:40:21 djgera smbd[27895]:    #6 /usr/sbin/smbd(Realloc+0x9c) [0x81eec53]
Jan  3 16:40:21 djgera smbd[27895]:    #7 /usr/sbin/smbd(convert_string_allocate+0x1d8) [0x81d8819]
Jan  3 16:40:21 djgera smbd[27895]:    #8 /usr/sbin/smbd(push_ucs2_allocate+0x4f) [0x81d94b7]
Jan  3 16:40:21 djgera smbd[27895]:    #9 /usr/sbin/smbd(unix_strupper+0x18) [0x81d8d19]
Jan  3 16:40:21 djgera smbd[27895]:    #10 /usr/sbin/smbd(strupper_m+0x74) [0x81e7b5e]
Jan  3 16:40:21 djgera smbd[27895]:    #11 /usr/sbin/smbd [0x80e287b]
Jan  3 16:40:21 djgera smbd[27895]:    #12 /usr/sbin/smbd [0x80e34fb]
Jan  3 16:40:21 djgera smbd[27895]:    #13 /usr/sbin/smbd(mangle_map+0x61) [0x80e0f4f]
Jan  3 16:40:21 djgera smbd[27895]:    #14 /usr/sbin/smbd [0x80b39b0]
Jan  3 16:40:21 djgera smbd[27895]:    #15 /usr/sbin/smbd [0x80b527a]
Jan  3 16:40:21 djgera smbd[27895]:    #16 /usr/sbin/smbd(reply_trans2+0x965) [0x80bf447]
Jan  3 16:40:21 djgera smbd[27895]:    #17 /usr/sbin/smbd [0x80d6fc7]
Jan  3 16:40:21 djgera smbd[27895]:    #18 /usr/sbin/smbd [0x80d709d]
Jan  3 16:40:21 djgera smbd[27895]:    #19 /usr/sbin/smbd(process_smb+0x217) [0x80d7436]
Jan  3 16:40:21 djgera smbd[27895]:    #20 /usr/sbin/smbd(smbd_process+0x195) [0x80d817d]
Jan  3 16:40:21 djgera smbd[27895]:    #21 /usr/sbin/smbd(main+0x851) [0x8255d03]
Jan  3 16:40:21 djgera smbd[27895]:    #22 /lib/libc.so.6(__libc_start_main+0xc6) [0x401ec916]
Jan  3 16:40:21 djgera smbd[27895]:    #23 /usr/sbin/smbd(chroot+0x35) [0x8071ec1]



chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
