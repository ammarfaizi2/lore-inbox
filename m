Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWDTX3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWDTX3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWDTX3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:29:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:24485 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751279AbWDTX3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:29:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=jg1Hmjg5bQjun9SfPPdsZ3jn3WyAE8BZ9+hTvf4YChlRhDSde0F93HemCjESzcb7RC+KqkWYg2SOcungSYNTQTYcqBHJsg1gBNmrwOj/Y7AJZp3mJHyCN9qcyamobahbVPjGtIn6yTqjYucWFyPTXz846/F07Dw//ECtQOZXwww=
Message-ID: <44481ACE.9040104@gmail.com>
Date: Fri, 21 Apr 2006 06:35:42 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which process is associated with process ID 0 (swapper)
References: <4447A19E.9000008@gmail.com> <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com> <4447B110.4080700@gmail.com> <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Engelhardt wrote:
> Is your code doing it like ipt_owner does?

It seems that ipt_owner does _not_ support PID match anymore:

In /usr/src/linux/net/ipv4/netfilter/ipt_owner.c:

...
if (info->match & (IPT_OWNER_PID|IPT_OWNER_SID|IPT_OWNER_COMM)) {
        printk("ipt_owner: pid, sid and command matching "
               "not supported anymore\n");
        return 0;
}
...

My main objective simply works on single-processor machine, I haven't
intend to do it on SMP one.

Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESBrONWc9T2Wr2JcRAnSiAJ9oAMtw0zZ0TcmnSXciuHmWry0sXACfT6M1
o86fk6onyQo/CVz9xIwZK1E=
=e9qN
-----END PGP SIGNATURE-----
