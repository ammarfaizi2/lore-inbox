Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWFWMdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWFWMdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFWMdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:33:36 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:59663 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964781AbWFWMd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:33:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KwLJnYfPiFshOHKLowhKrP/ZSLXWZ4kJ4V4SSWe8r9k6Drxo3cbKXgqZZPLhUbyBaeiK3hbxLigxp7s+hw0F6HF9w5uKQktfTFiRtU0Rxsx5+shUJ2O4TH6xLL4okmTXnKRVX7uc1vXh8978rCY4TYeAGBYg809bQJmYW558yfc=
Message-ID: <6bffcb0e0606230533g7fd1dac5m16c62d035b4e9896@mail.gmail.com>
Date: Fri, 23 Jun 2006 14:33:27 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm1
Cc: "Ingo Molnar" <mingo@elte.hu>, "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621034857.35cfe36f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
>

Firefox 2 - a new testing tool for bug hunters.

Jun 23 11:03:48 ltg01-fedora kernel: =======================================
Jun 23 11:03:48 ltg01-fedora kernel: [ INFO: out of order unlock detected. ]
Jun 23 11:03:48 ltg01-fedora kernel: ---------------------------------------
Jun 23 11:03:48 ltg01-fedora kernel: The code is fine but needs lock
validator annotation.
Jun 23 11:03:48 ltg01-fedora kernel: firefox-bin/25734 is trying to
release lock (tasklist_lock) at:
Jun 23 11:03:48 ltg01-fedora kernel:  [<c017b02c>] flush_old_exec+0x12f/0xa5f
Jun 23 11:03:48 ltg01-fedora kernel: but the next lock to release is:
Jun 23 11:03:48 ltg01-fedora kernel:  (&sighand->siglock){++..}, at:
[<c017afab>] flush_old_exec+0xae/0xa5f
Jun 23 11:03:48 ltg01-fedora kernel:
Jun 23 11:03:48 ltg01-fedora kernel: other info that might help us debug this:
Jun 23 11:03:48 ltg01-fedora kernel: 2 locks held by firefox-bin/25734:
Jun 23 11:03:48 ltg01-fedora kernel:  #0:  (tasklist_lock){..??}, at:
[<c017afa4>] flush_old_exec+0xa7/0xa5f
Jun 23 11:03:48 ltg01-fedora kernel:  #1:  (&sighand->siglock){++..},
at: [<c017afab>] flush_old_exec+0xae/0xa5f
Jun 23 11:03:48 ltg01-fedora kernel:
Jun 23 11:03:48 ltg01-fedora kernel: stack backtrace:
Jun 23 11:03:48 ltg01-fedora kernel:  [<c0103e89>] show_trace+0xd/0x10
Jun 23 11:03:48 ltg01-fedora kernel:  [<c0104483>] dump_stack+0x19/0x1b
Jun 23 11:03:48 ltg01-fedora kernel:  [<c0139c52>] lock_release+0x19a/0x371
Jun 23 11:03:48 ltg01-fedora kernel:  [<c02f1148>] _read_unlock+0x16/0x46
Jun 23 11:03:48 ltg01-fedora kernel:  [<c017b02c>] flush_old_exec+0x12f/0xa5f
Jun 23 11:03:48 ltg01-fedora kernel:  [<c019b698>] load_elf_binary+0x4c8/0x15f4
Jun 23 11:03:48 ltg01-fedora kernel:  [<c017a8e1>]
search_binary_handler+0xfc/0x32b
Jun 23 11:03:48 ltg01-fedora kernel:  [<c017c533>] do_execve+0x16c/0x225
Jun 23 11:03:48 ltg01-fedora kernel:  [<c01016e1>] sys_execve+0x3a/0x8b
Jun 23 11:03:48 ltg01-fedora kernel:  [<c02f157d>] sysenter_past_esp+0x56/0x8d

Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.17-mm1/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
