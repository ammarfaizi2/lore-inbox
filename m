Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbRBLV2y>; Mon, 12 Feb 2001 16:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130823AbRBLV2o>; Mon, 12 Feb 2001 16:28:44 -0500
Received: from mx.interplus.ro ([193.231.252.3]:17164 "EHLO mx.interplus.ro")
	by vger.kernel.org with ESMTP id <S130570AbRBLV2e>;
	Mon, 12 Feb 2001 16:28:34 -0500
Message-ID: <3A8855DB.8EEC1170@interplus.ro>
Date: Mon, 12 Feb 2001 23:30:03 +0200
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac10 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: Linux-kernel@vger.kernel.org
Subject: LARGE bug with 2.4.1ac10 and loop filesystem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I think I hit a bug introduced between 2.4.1ac9 and 2.4.1ac10,
and a
really bad one I belive :(.
Bug description:
        Distribution: Linux Mandrake 7.2
        Machine Dual PIII-950, Asus CUBX-E motheboard, 256MB RAM
        Compiler (kgcc -v):Reading specs from
/usr/lib/gcc-lib/i586-mandrake-linux/egcs-2.91.66/specs
                        gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)
        Filesystem "loop" compiled as module, filesystem "iso9660" and
juliet
extension compiled in kernel.
        Symptom: When trying to: mount blah.iso /mnt/cdrom -o loop, the
console
hangs, Ctrl-C can not interrupt the command, kill can not kill the
stalled mount process and while rebooting none of the filesystems are
unmounted cleanly ( it squirts messeages like umount2: / is busy,
umount2: /home is busy, etc) and on restart the filesystems are checked
but fortunately no errors are found.
        By greping the patch I see that some interlocks were added on
the loop
filesystem but I have no knowledge of the intricate mechanism of the
filesystem to correct the problem :(.
        Kernel 2.4.1ac9 works OK from that point of view.
        Please advise me how can I help with debugging of that further.

                Thank you,

                Mircea C.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
