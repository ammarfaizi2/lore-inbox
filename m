Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVGFVvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVGFVvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVGFUKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:10:31 -0400
Received: from host133.trustnet.pl ([213.76.154.133]:39345 "EHLO
	rex.trustnet.pl") by vger.kernel.org with ESMTP id S262492AbVGFTGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:06:39 -0400
Message-ID: <42CC2D28.1080103@trustnet.pl>
Date: Wed, 06 Jul 2005 21:12:40 +0200
From: Daniel Kubiak <sor@trustnet.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6 amd64 nVidia problem
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

	I have router (with squid proxy and QOS) on amd athlon64 3000+,
Giga-Byte K8NSC-939 mainboard (nVidia nForce3 250) and 2GB of RAM 400MHz
in dual channel, but it's very unstable. I was trying 2.6.11.12,
2.6.12-rc2 and 2.6.12.2, all with pom-ng and IMQ patches. In kernel.log
i have:

Jul  4 20:48:46 router kernel: Call
Trace:<ffffffff8034953a>{schedule+122} <ffffffff8010b820>{default_idle+0}
Jul  4 20:48:46 router kernel:        <ffffffff8010b972>{cpu_idle+82}
<ffffffff804b280e>{start_kernel+350}
Jul  4 20:48:46 router kernel:        <4>warning: many lost ticks.
Jul  4 20:48:46 router kernel: Your time source seems to be instable or
some driver is hogging interupts
Jul  4 20:48:46 router kernel: rip release_console_sem+0x3e/0xb0
Jul  4 20:48:46 router kernel: <ffffffff804b226a>{x86_64_start_kernel+362}
Jul  4 20:48:46 router kernel: scheduling while atomic: swapper/0x00000100/0
Jul  4 20:48:46 router kernel:
Jul  4 20:48:46 router kernel: Call
Trace:<ffffffff8034953a>{schedule+122} <ffffffff8010b820>{default_idle+0}
Jul  4 20:48:46 router kernel:        <ffffffff8010b972>{cpu_idle+82}
<ffffffff804b280e>{start_kernel+350}
Jul  4 20:48:46 router kernel:
<ffffffff804b226a>{x86_64_start_kernel+362}
Jul  4 20:48:46 router kernel: scheduling while atomic: swapper/0x00000100/0

[...]
Jul  4 22:20:45 router kernel: scheduling while atomic: swapper/0x00000100/0
Jul  4 22:20:45 router kernel:
Jul  4 22:20:45 router kernel: Call
Trace:<ffffffff8034953a>{schedule+122} <ffffffff8010b820>{default_idle+0}
Jul  4 22:20:45 router kernel:        <ffffffff8010b972>{cpu_idle+82}
<ffffffff804b280e>{start_kernel+350}
Jul  4 22:20:45 router kernel:
<ffffffff804b226a>{x86_64_start_kernel+362}
Jul  4 22:20:45 router kernel: scheduling while atomic: swapper/0x00000100/0
Jul  4 22:20:45 router kernel:
Jul  4 22:20:45 router kernel: Call
Trace:<ffffffff8034953a>{schedule+122} <ffffffff8010b820>{default_idle+0}
Jul  4 22:20:45 router kernel:        <ffffffff8010b972>{cpu_idle+82}
<ffffffff804b280e>{start_kernel+350}
Jul  4 22:20:45 router kernel:
<ffffffff804b226a>{x86_64_start_kernel+362}
Jul  4 22:20:45 router kernel: scheduling while atomic: swapper/0x00000100/0
Jul  4 22:20:45 router kernel:
Jul  4 22:20:45 router kernel: Call
Trace:<ffffffff8034953a>{schedule+122} <ffffffff8010b820>{default_idle+0}
Jul  4 22:20:45 router kernel:        <ffffffff8010b972>{cpu_idle+82}
<ffffffff804b280e>{start_kernel+350}
Jul  4 22:20:45 router kernel:
<ffffffff804b226a>{x86_64_start_kernel+362}
Jul  4 22:20:45 router kernel: scheduling while atomic: swapper/0x00000100/0
Jul  4 22:20:45 router kernel:
Jul  4 22:20:45 router kernel: Call
Trace:<ffffffff8034953a>{schedule+122} <ffffffff8010b820>{default_idle+0}
Jul  4 22:20:45 router kernel:        <ffffffff8010b972>{cpu_idle+82}
<ffffffff804b280e>{start_kernel+350}
Jul  4 22:20:45 router kernel:
<ffffffff804b226a>{x86_64_start_kernel+362}
Jul  4 22:20:45 router kernel: scheduling while atomic: swapper/0x00000100/0
Jul  4 22:20:45 router kernel:

When acpi=off I don't have problem with timer (Your time source seems to
be instable or some driver is hogging interupts), but router in still
hanging after ~8h work. in kernel.log I have:

Jul  6 20:02:30 router kernel:
Jul  6 20:02:30 router kernel: Call
Trace:<ffffffff803527ba>{schedule+122} <ffffffff8015b668>{vfs_read+232}
Jul  6 20:02:30 router kernel:        <ffffffff8015b913>{sys_read+83}
<ffffffff8010dc05>{retint_careful+13}
Jul  6 20:02:30 router kernel:
Jul  6 20:02:30 router kernel: scheduling while atomic:
bash/0x00000100/22524
Jul  6 20:02:30 router kernel:
Jul  6 20:02:30 router kernel: Call
Trace:<ffffffff803527ba>{schedule+122}
<ffffffff8012214e>{release_console_sem+62}
Jul  6 20:02:30 router kernel:        <ffffffff8012204c>{vprintk+476}
<ffffffff80353565>{schedule_timeout+37}
Jul  6 20:02:30 router kernel:        <ffffffff8029d2c0>{con_write+32}
<ffffffff80292d5d>{read_chan+877}
Jul  6 20:02:30 router kernel:
<ffffffff8011e510>{default_wake_function+0}
<ffffffff8011e510>{default_wake_function+0}
Jul  6 20:02:30 router kernel:
<ffffffff8011e510>{default_wake_function+0} <ffffffff8028de3c>{tty_read+156}
Jul  6 20:02:30 router kernel:        <ffffffff8015b63f>{vfs_read+191}
<ffffffff8015b913>{sys_read+83}
Jul  6 20:02:30 router kernel:        <ffffffff8010d5ea>{system_call+126}
Jul  6 20:02:30 router kernel: scheduling while atomic:
bash/0x00000100/22524
Jul  6 20:02:30 router kernel:
Jul  6 20:02:30 router kernel: Call
Trace:<ffffffff803527ba>{schedule+122}
<ffffffff8012214e>{release_console_sem+62}
Jul  6 20:02:30 router kernel:        <ffffffff8012204c>{vprintk+476}
<ffffffff80353565>{schedule_timeout+37}
Jul  6 20:02:30 router kernel:        <ffffffff8029d2c0>{con_write+32}
<ffffffff80292d5d>{read_chan+877}
Jul  6 20:02:30 router kernel:
<ffffffff8011e510>{default_wake_function+0}
<ffffffff8011e510>{default_wake_function+0}
Jul  6 20:02:30 router kernel:
<ffffffff8011e510>{default_wake_function+0} <ffffffff8028de3c>{tty_read+156}
Jul  6 20:02:30 router kernel:        <ffffffff8015b63f>{vfs_read+191}
<ffffffff8015b913>{sys_read+83}
Jul  6 20:02:30 router kernel:        <ffffffff8010d5ea>{system_call+126}
Jul  6 20:02:30 router kernel: scheduling while atomic: swapper/0x00000100/0
Jul  6 20:02:30 router kernel:
Jul  6 20:02:30 router kernel: Call
Trace:<ffffffff803527ba>{schedule+122} <ffffffff8010b820>{default_idle+0}
Jul  6 20:02:30 router kernel:        <ffffffff8010b972>{cpu_idle+82}
<ffffffff804b480e>{start_kernel+350}
Jul  6 20:02:30 router kernel:
<ffffffff804b423f>{x86_64_start_kernel+319}
Jul  6 20:02:30 router kernel: scheduling while atomic:
bash/0x00000100/22524

I don't know where is the problem,
thanks for any help
Daniel Kubiak
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCzC0njvzoNej1O7YRAukOAJ96oWB1WEoaoTq9gbkECRTbu6kZqACgknF0
OmZ/rKXHduZjnE3C0w5ehJQ=
=r9l7
-----END PGP SIGNATURE-----
