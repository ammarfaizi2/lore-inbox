Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUB2HdD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUB2HdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:33:02 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:42829 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262008AbUB2Hbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:31:47 -0500
Date: Sun, 29 Feb 2004 02:33:57 -0500
From: Robert F Merrill <griever@t2n.org>
Subject: 2.6.3-mm4 first run
To: linux-kernel@vger.kernel.org
Message-id: <404195E5.4010601@t2n.org>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
 Debian/1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just booted to .3-mm4 for the first time, already found 2 or 3 bugs:

- Two old bugs still there: in both radeonfb and vgafb, the lines above
  the first one printed after the fb takeover are white (vgafb) or 
mangled (radeonfb).

- New radeonfb bug: in the fb console, linefeed doesn't clear the new 
line., i.e the three lines

ABCDEFGHI
JKLMNO
PQR

would look like:

ABCDEFGHI
JKLMNO
PQRMNOGHI

- ipv6.ko doesn't work:

ipv6: Unknown symbol sysctl_optmem_max
ipv6: Unknown symbol sysctl_optmem_max
ipv6: Unknown symbol sysctl_optmem_max
ipv6: Unknown symbol sysctl_optmem_max

The symbol is listed in System.map however:
/boot/System.map-2.6.3-mm4:c0301ff0 D sysctl_optmem_max

Nothing serious, or as bad as .2-mm1 was.

Thanks to everyone involved in making it, hope this helps!


