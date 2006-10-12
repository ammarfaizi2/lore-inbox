Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWJLM1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWJLM1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWJLM13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:27:29 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12188 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751368AbWJLM12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:27:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FODKzLSH+9JExCeW4TNWjH9slmT0dFlEaK2f39Ok9z+EEL70TTZg4sLb+JmY3H8Fv4PbNkEwhOfF1I101th8M9O5KslA8+9L6QruN6twVVArhEvkKLoT6zQq/caMM8QsdHRgS36eXowIq5LZYKKfYxvR8ATXEykaHoDF/SDa0KI=
Message-ID: <4b3406f0610120527g42bfbc44q45b31dc07f5968de@mail.gmail.com>
Date: Thu, 12 Oct 2006 20:27:28 +0800
From: "Dongsheng Song" <dongsheng.song@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: maybe headers(linux/aio.h) bug ?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I include linux aio header,  the compile errors occured:

$  cat test.c
#include <linux/types.h>
#include <linux/unistd.h>
#include <linux/aio.h>

$ gcc-4.1 test.c
In file included from /usr/include/linux/workqueue.h:8,
                 from /usr/include/linux/aio.h:5,
                 from test.c:3:
/usr/include/linux/timer.h:12: error: field 'entry' has incomplete type
/usr/include/linux/timer.h:34: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'init_timer'
In file included from /usr/include/linux/aio.h:5,
                 from test.c:3:
/usr/include/linux/workqueue.h:16: error: field 'entry' has incomplete type
In file included from /usr/include/linux/cpumask.h:86,
                 from /usr/include/asm-i486/processor.h:23,
                 from /usr/include/asm/processor.h:8,
                 from /usr/include/asm-i486/atomic.h:6,
                 from /usr/include/asm/atomic.h:8,
                 from /usr/include/linux/aio.h:8,
                 from test.c:3:
/usr/include/linux/bitmap.h: In function 'bitmap_zero':
/usr/include/linux/bitmap.h:128: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h:128: error: (Each undeclared identifier is
reported only once
/usr/include/linux/bitmap.h:128: error: for each function it appears in.)
/usr/include/linux/bitmap.h: In function 'bitmap_fill':
/usr/include/linux/bitmap.h:143: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_copy':
/usr/include/linux/bitmap.h:149: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_and':
/usr/include/linux/bitmap.h:160: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_or':
/usr/include/linux/bitmap.h:169: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_xor':
/usr/include/linux/bitmap.h:178: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_andnot':
/usr/include/linux/bitmap.h:187: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_complement':
/usr/include/linux/bitmap.h:196: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_equal':
/usr/include/linux/bitmap.h:205: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_intersects':
/usr/include/linux/bitmap.h:214: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_subset':
/usr/include/linux/bitmap.h:223: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_empty':
/usr/include/linux/bitmap.h:231: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_full':
/usr/include/linux/bitmap.h:239: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_shift_right':
/usr/include/linux/bitmap.h:253: error: 'BITS_PER_LONG' undeclared
(first use in this function)
/usr/include/linux/bitmap.h: In function 'bitmap_shift_left':
/usr/include/linux/bitmap.h:262: error: 'BITS_PER_LONG' undeclared
(first use in this function)
In file included from /usr/include/asm-i486/processor.h:23,
                 from /usr/include/asm/processor.h:8,
                 from /usr/include/asm-i486/atomic.h:6,
                 from /usr/include/asm/atomic.h:8,
                 from /usr/include/linux/aio.h:8,
                 from test.c:3:
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:88: error: expected
specifier-qualifier-list before 'DECLARE_BITMAP'
/usr/include/linux/cpumask.h: In function '__cpu_set':
/usr/include/linux/cpumask.h:94: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpu_clear':
/usr/include/linux/cpumask.h:100: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_setall':
/usr/include/linux/cpumask.h:106: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_clear':
/usr/include/linux/cpumask.h:112: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpu_test_and_set':
/usr/include/linux/cpumask.h:121: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_and':
/usr/include/linux/cpumask.h:128: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:128: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:128: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_or':
/usr/include/linux/cpumask.h:135: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:135: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:135: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_xor':
/usr/include/linux/cpumask.h:142: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:142: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:142: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_andnot':
/usr/include/linux/cpumask.h:150: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:150: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:150: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_complement':
/usr/include/linux/cpumask.h:157: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:157: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_equal':
/usr/include/linux/cpumask.h:164: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:164: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_intersects':
/usr/include/linux/cpumask.h:171: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:171: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_subset':
/usr/include/linux/cpumask.h:178: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:178: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_empty':
/usr/include/linux/cpumask.h:184: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_full':
/usr/include/linux/cpumask.h:190: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_weight':
/usr/include/linux/cpumask.h:196: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_shift_right':
/usr/include/linux/cpumask.h:204: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:204: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_shift_left':
/usr/include/linux/cpumask.h:212: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:212: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpumask_scnprintf':
/usr/include/linux/cpumask.h:273: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpumask_parse':
/usr/include/linux/cpumask.h:281: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpulist_scnprintf':
/usr/include/linux/cpumask.h:289: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpulist_parse':
/usr/include/linux/cpumask.h:295: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpu_remap':
/usr/include/linux/cpumask.h:303: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:303: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h: In function '__cpus_remap':
/usr/include/linux/cpumask.h:311: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:311: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:311: error: 'cpumask_t' has no member named 'bits'
/usr/include/linux/cpumask.h:311: error: 'cpumask_t' has no member named 'bits'
In file included from test.c:3:
/usr/include/linux/aio.h: At top level:
/usr/include/linux/aio.h:86: error: field 'ki_run_list' has incomplete type
/usr/include/linux/aio.h:103: error: expected specifier-qualifier-list
before 'wait_queue_t'
/usr/include/linux/aio.h:180: error: expected specifier-qualifier-list
before 'wait_queue_head_t'
/usr/include/linux/aio.h: In function 'list_kiocb':
/usr/include/linux/aio.h:243: error: expected expression before 'struct'

When I using gcc-3.4, same errors occured.

Here is those related packages version:
ii  linux-headers-2.6.17-2          2.6.17-9
Commonheader files for Linux 2.6.17
ii  linux-headers-2.6.17-2-686      2.6.17-9               Headerfiles
for Linux 2.6.17 on PPro/Celero
ii  linux-kernel-headers            2.6.17.10-3            LinuxKernel
Headers for development
ii  libc6                           2.3.6.ds1-4            GNU C
Library: Shared libraries
ii  libc6-dev                       2.3.6.ds1-4            GNU C
Library: Development Libraries and Hea
ii  libc6-i686                      2.3.6.ds1-4            GNU C
Library: Shared libraries [i686 optimi
ii  gcc-3.4                         3.4.6-4                The GNU C compiler
ii  gcc-4.1                         4.1.1-13               The GNU C compiler

Thanks for some help
