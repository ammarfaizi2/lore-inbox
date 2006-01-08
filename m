Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWAHHm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWAHHm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWAHHm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:42:29 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:6019 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030398AbWAHHm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:42:28 -0500
From: Grant Coady <gcoady@gmail.com>
To: be-news06@lina.inka.de (Bernd Eckenfels)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Sun, 08 Jan 2006 18:42:25 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <irf1s1hdoqbsf9cin627gh9tgrsb51htoe@4ax.com>
References: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com> <E1EvUp6-0008Ni-00@calista.inka.de>
In-Reply-To: <E1EvUp6-0008Ni-00@calista.inka.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Jan 2006 08:18:40 +0100, be-news06@lina.inka.de (Bernd Eckenfels) wrote:

>Markus Rechberger <mrechberger@gmail.com> wrote:
>> Hi,
>> 
>> what does hdparm show up?
>> Were there any other processes running during the test?
>> what does "vmstat 1" show up during the test?
>
>also also retry with redirection to /dev/null, this could be a console
>problem since there is 5 minutes wait time.

Excuse me?  there is no 5 minutes wait time ;)

grant@deltree:~$ uname -r
2.4.32-hf32.1
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96

real    0m1.671s
user    0m0.550s
sys     0m0.300s
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96 >/dev/null

real    0m0.510s
user    0m0.420s
sys     0m0.080s

grant@deltree:~$ uname -r
2.6.14.6a
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96 >/dev/null
real    0m6.463s
user    0m0.770s
sys     0m0.990s
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96 >/dev/null

real    0m0.524s
user    0m0.400s
sys     0m0.130s

Yes, the delay is in the console, that's what I'm talking about ;)
A very perceivable, measurable sluggishness in 2.6 CLI over ssh.

Same thing on 2.6.14.6 screen console is (copy by hand):
real 0m1.374s
user 0m0.510s
sys  0m0.960s

-- 
Thanks,
Grant.
http://bugsplatter.mine.nu/
