Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbUBZNey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUBZNey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:34:54 -0500
Received: from main.gmane.org ([80.91.224.249]:2176 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262799AbUBZNeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:34:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: How to emulate 'chroot /jail/ su httpd -c' ?
Date: Thu, 26 Feb 2004 14:34:45 +0100
Message-ID: <yw1xllmqhslm.fsf@kth.se>
References: <200402261956.BEF40183.2B918856@anet.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:C7KNyKc0IdXCufd+cpBfphDJTdA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <a5497108@anet.ne.jp> writes:

> Hello,
>
> Sorry for querying userland program in this list.
>
> I have the following line in /etc/rc.d/init.d/httpd
>
> daemon chroot /jail/ su httpd -c $httpd $OPTIONS
>
> This needs /bin/su after /usr/sbin/chroot, but I don't
> want to place /bin/su (and related files) in the jail.
> So, I want to do this with one program.

If you remove the suid bit from the su program in the chroot it should
be rather harmless.

-- 
Måns Rullgård
mru@kth.se

