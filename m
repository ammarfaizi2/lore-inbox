Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129153AbQJ3GUc>; Mon, 30 Oct 2000 01:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbQJ3GUV>; Mon, 30 Oct 2000 01:20:21 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:57126 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129153AbQJ3GUJ>; Mon, 30 Oct 2000 01:20:09 -0500
Message-ID: <39FCDB16.B0955558@mindspring.com>
Date: Sun, 29 Oct 2000 21:21:11 -0500
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc & xml data
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember hearing about various debates about the /proc structure.  I
was wondering if anyone had ever considered storing some of the data in
xml format rather than its current format?  Things like /proc/meminfo
and cpuinfo may work good in this format as then it would be easy to
write a generic xml parser that could then be used to parse any of the
data. "MemTotal:  %8lu kB\n"

In the case of the meminfo it would be a matter of changing the lines in
fs/proc/array.c  function get_meminfo(char * buffer) from

"MemTotal:  %8lu kB\n"

to something like

"<memtotal>%8lu kB</memtotal>\n"



Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
