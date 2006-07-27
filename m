Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWG0R7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWG0R7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWG0R7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:59:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5071 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750776AbWG0R7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:59:51 -0400
Message-ID: <44C8FF00.80106@redhat.com>
Date: Fri, 28 Jul 2006 01:59:28 +0800
From: Eugene Teo <eteo@redhat.com>
Organization: Red Hat Asia-Pacific
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Marcel Holtmann <marcel@holtmann.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Require mmap handler for a.out executables
References: <6COYh-8f0-41@gated-at.bofh.it> <E1G69zn-0001Wb-66@be1.lrz>
In-Reply-To: <E1G69zn-0001Wb-66@be1.lrz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Marcel Holtmann <marcel@holtmann.org> wrote:
> 
>> with the nasty /proc privilege escalation (CVE-2006-3626) it became
>> clear that we need to do something more to better protect us against
>> people exploiting stuff in /proc. Besides the don't allow chmod stuff,
>> Eugene also proposed to depend the a.out execution on the existence of
>> the mmap handler. Since we are doing the same for ELF, this makes
>> totally sense to me.
> 
> Can shell scripts or binfmt_misc be exploited, too? Even if not, I'd
> additionally force noexec, nosuid on proc and sysfs mounts.

Right. That's why we do not allow chmod() /proc/*/*/* files.
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6d76fa58b050044994fe25f8753b8023f2b36737

Eugene
-- 
eteo redhat.com  ph: +65 6490 4142  http://www.kernel.org/~eugeneteo
gpg fingerprint:  47B9 90F6 AE4A 9C51 37E0  D6E1 EA84 C6A2 58DF 8823
