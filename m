Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291418AbSBHFHQ>; Fri, 8 Feb 2002 00:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291415AbSBHFHJ>; Fri, 8 Feb 2002 00:07:09 -0500
Received: from [24.93.35.42] ([24.93.35.42]:17369 "EHLO sm11.texas.rr.com")
	by vger.kernel.org with ESMTP id <S291414AbSBHFGw>;
	Fri, 8 Feb 2002 00:06:52 -0500
Message-ID: <003201c1b05e$5e128150$1cbaa218@HomeServer>
Reply-To: "Bryan Parkoff" <BParkoff@satx.rr.com>
From: "Bryan Parkoff" <BParkoff@satx.rr.com>
To: <linux-kernel@vger.kernel.org>, <linux-tape@vger.kernel.org>
Subject: Need Help With Kernel & Tape
Date: Thu, 7 Feb 2002 23:06:29 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2526.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

    Linux-Kernel and Linux-Tape are part of ftape-4.04a.  I have followed
all the procedures including FAQs and HOWTOs, but none of them provide the
information to meet my needs to resolve the problem.

    I have Kernel v2.4.16 and Ftape v4.04a.  I use Iomega/Tecmar DittoMax
Pro 4Mbps controller card as ISAPNP.(o?) and internal.(o?).  I did type
./gokernel.sh /usr/src/linux /usr/src/ftape-4.04a to copy and patch some
latest ftape's source code and files into Kernel v2.4.16's subdirectory.

    I tried to compile Kernel v2.4.16 by giving "*" in ftape submenu, but I
receive error message: ftape_init().  I believe that I am not allowed to use
ISAPNP that is built in Kernel 2.4.16, but I am allowed to use module
instead.  I did try to recompile by placing "m" in ftape submenu AND by
placing " " in ftape submenu, but it did recompile everything except it did
not compile and install ftape modules under /lib/modules...  I don't know
why.

    I did compile ftape-4.04a, but I get error message like warning:
pasting -- not valid preprocessing token.  I have enclosed a compilation log
there.  Please take a look.  Please give me an idea what is going on.

    I appreciate that you are willing to help and answer the questions.

[root@HomeServer ftape-4.04a]# make
for i in ftape ; do make -C $i all ; done
make[1]: Entering directory `/usr/src/ftape-4.04a/ftape'
for i in  lowlevel internal parport zftape compressor; \
do \
  make -C $i NODEP=true versions; \
done
make[2]: Entering directory `/usr/src/ftape-4.04a/ftape/lowlevel'
gcc -D__KERNEL__ -I. -I../../include -I/usr/src/linux/include  -E -D__GENKSY
MS__ ftape_syms.c | /sbin/genksyms -k 2.4.17  >
../../include/linux/modules/ftape_syms.ver.tmp; mv
../../include/linux/modules/ftape_syms.ver.tmp
../../include/linux/modules/ftape_syms.ver
ftape_syms.c:58:1: warning: pasting "(" and "ftape_get_bad_sector_entry"
does not give a valid preprocessing token
ftape_syms.c:59:1: warning: pasting "(" and "ftape_find_end_of_bsm_list"
does not give a valid preprocessing token
ftape_syms.c:61:1: warning: pasting "(" and "ftape_set_state" does not give
a valid preprocessing token
ftape_syms.c:63:1: warning: pasting "(" and "ftape_seek_to_bot" does not
give a valid preprocessing token
ftape_syms.c:64:1: warning: pasting "(" and "ftape_seek_to_eot" does not
give a valid preprocessing token
ftape_syms.c:65:1: warning: pasting "(" and "ftape_abort_operation" does not
give a valid preprocessing token
ftape_syms.c:66:1: warning: pasting "(" and "ftape_get_status" does not give
a valid preprocessing token
ftape_syms.c:67:1: warning: pasting "(" and "ftape_enable" does not give a
valid preprocessing token
ftape_syms.c:68:1: warning: pasting "(" and "ftape_disable" does not give a
valid preprocessing token
ftape_syms.c:69:1: warning: pasting "(" and "ftape_destroy" does not give a
valid preprocessing token
ftape_syms.c:70:1: warning: pasting "(" and "ftape_calibrate_data_rate" does
not give a valid preprocessing token
ftape_syms.c:71:1: warning: pasting "(" and "ftape_get_drive_status" does
not give a valid preprocessing token
ftape_syms.c:73:1: warning: pasting "(" and "ftape_reset_drive" does not
give a valid preprocessing token
ftape_syms.c:74:1: warning: pasting "(" and "ftape_command" does not give a
valid preprocessing token
ftape_syms.c:75:1: warning: pasting "(" and "ftape_parameter" does not give
a valid preprocessing token
ftape_syms.c:76:1: warning: pasting "(" and "ftape_ready_wait" does not give
a valid preprocessing token
ftape_syms.c:77:1: warning: pasting "(" and "ftape_report_operation" does
not give a valid preprocessing token
ftape_syms.c:78:1: warning: pasting "(" and "ftape_report_error" does not
give a valid preprocessing token
ftape_syms.c:79:1: warning: pasting "(" and "ftape_door_lock" does not give
a valid preprocessing token
ftape_syms.c:80:1: warning: pasting "(" and "ftape_door_open" does not give
a valid preprocessing token
ftape_syms.c:81:1: warning: pasting "(" and "ftape_set_partition" does not
give a valid preprocessing token
ftape_syms.c:83:1: warning: pasting "(" and "ftape_ecc_correct" does not
give a valid preprocessing token
ftape_syms.c:84:1: warning: pasting "(" and "ftape_read_segment" does not
give a valid preprocessing token
ftape_syms.c:85:1: warning: pasting "(" and "ftape_zap_read_buffers" does
not give a valid preprocessing token
ftape_syms.c:86:1: warning: pasting "(" and "ftape_read_header_segment" does
not give a valid preprocessing token
ftape_syms.c:87:1: warning: pasting "(" and "ftape_decode_header_segment"
does not give a valid preprocessing token
ftape_syms.c:89:1: warning: pasting "(" and "ftape_write_segment" does not
give a valid preprocessing token
ftape_syms.c:90:1: warning: pasting "(" and "ftape_loop_until_writes_done"
does not give a valid preprocessing token
ftape_syms.c:91:1: warning: pasting "(" and "ftape_hard_error_recovery" does
not give a valid preprocessing token
ftape_syms.c:93:1: warning: pasting "(" and "fdc_infos" does not give a
valid preprocessing token
ftape_syms.c:94:1: warning: pasting "(" and "fdc_register" does not give a
valid preprocessing token
ftape_syms.c:95:1: warning: pasting "(" and "fdc_unregister" does not give a
valid preprocessing token
ftape_syms.c:96:1: warning: pasting "(" and "fdc_disable_irq" does not give
a valid preprocessing token
ftape_syms.c:97:1: warning: pasting "(" and "fdc_enable_irq" does not give a
valid preprocessing token
ftape_syms.c:99:1: warning: pasting "(" and "ftape_vmalloc" does not give a
valid preprocessing token
ftape_syms.c:100:1: warning: pasting "(" and "ftape_vfree" does not give a
valid preprocessing token
ftape_syms.c:101:1: warning: pasting "(" and "ftape_kmalloc" does not give a
valid preprocessing token
ftape_syms.c:102:1: warning: pasting "(" and "ftape_kfree" does not give a
valid preprocessing token
ftape_syms.c:103:1: warning: pasting "(" and "fdc_set_nr_buffers" does not
give a valid preprocessing token
ftape_syms.c:104:1: warning: pasting "(" and "fdc_get_deblock_buffer" does
not give a valid preprocessing token
ftape_syms.c:105:1: warning: pasting "(" and "fdc_put_deblock_buffer" does
not give a valid preprocessing token
ftape_syms.c:107:1: warning: pasting "(" and "ftape_format_track" does not
give a valid preprocessing token
ftape_syms.c:108:1: warning: pasting "(" and "ftape_format_status" does not
give a valid preprocessing token
ftape_syms.c:109:1: warning: pasting "(" and "ftape_verify_segment" does not
give a valid preprocessing token
ftape_syms.c:111:1: warning: pasting "(" and "ftape_ecc_set_segment_parity"
does not give a valid preprocessing token
ftape_syms.c:112:1: warning: pasting "(" and "ftape_ecc_correct_data" does
not give a valid preprocessing token
ftape_syms.c:115:1: warning: pasting "(" and "ftape_trace_call" does not
give a valid preprocessing token
ftape_syms.c:116:1: warning: pasting "(" and "ftape_trace_exit" does not
give a valid preprocessing token
ftape_syms.c:117:1: warning: pasting "(" and "ftape_trace_log" does not give
a valid preprocessing token
ftape_syms.c:118:1: warning: pasting "(" and "ftape_tracings" does not give
a valid preprocessing token
ftape_syms.c:119:1: warning: pasting "(" and "ftape_function_nest_levels"
does not give a valid preprocessing token
updating ../../include/linux/modftversions.h
make[2]: Leaving directory `/usr/src/ftape-4.04a/ftape/lowlevel'
make[2]: Entering directory `/usr/src/ftape-4.04a/ftape/internal'
make[2]: Nothing to be done for `versions'.
make[2]: Leaving directory `/usr/src/ftape-4.04a/ftape/internal'
make[2]: Entering directory `/usr/src/ftape-4.04a/ftape/parport'
make[2]: Nothing to be done for `versions'.
make[2]: Leaving directory `/usr/src/ftape-4.04a/ftape/parport'
make[2]: Entering directory `/usr/src/ftape-4.04a/ftape/zftape'
gcc -D__KERNEL__ -I. -I../../include -I/usr/src/linux/include  -E -D__GENKSY
MS__ zftape_syms.c | /sbin/genksyms -k 2.4.17  >
../../include/linux/modules/zftape_syms.ver.tmp; mv
../../include/linux/modules/zftape_syms.ver.tmp
../../include/linux/modules/zftape_syms.ver
zftape_syms.c:50:1: warning: pasting "(" and "zft_cmpr_register" does not
give a valid preprocessing token
zftape_syms.c:51:1: warning: pasting "(" and "zft_cmpr_unregister" does not
give a valid preprocessing token
zftape_syms.c:54:1: warning: pasting "(" and "zft_fetch_segment" does not
give a valid preprocessing token
zftape_syms.c:56:1: warning: pasting "(" and "zft_vmalloc_once" does not
give a
valid preprocessing token
zftape_syms.c:57:1: warning: pasting "(" and "zft_vmalloc_always" does not
give
a valid preprocessing token
updating ../../include/linux/modftversions.h
make[2]: Leaving directory `/usr/src/ftape-4.04a/ftape/zftape'
make[2]: Entering directory `/usr/src/ftape-4.04a/ftape/compressor'
make[2]: Nothing to be done for `versions'.
make[2]: Leaving directory `/usr/src/ftape-4.04a/ftape/compressor'
set -e; for i in  lowlevel internal parport zftape compressor; do make -C $i
modules; done
make[2]: Entering directory `/usr/src/ftape-4.04a/ftape/lowlevel'
make[2]: *** No rule to make target
`/usr/src/linux/include/linux/modules/bio.ver', needed by `.ftape_syms.d'.
Stop.
make[2]: Leaving directory `/usr/src/ftape-4.04a/ftape/lowlevel'
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/ftape-4.04a/ftape'
make: *** [all] Error 2
[root@HomeServer ftape-4.04a]#
Yours Truly,

Bryan Parkoff
BParkoff@satx.rr.com

