Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267296AbTGTOmF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267300AbTGTOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:42:04 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:5255 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S267296AbTGTOlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:41:53 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307201457.PAA18000@mauve.demon.co.uk>
Subject: 2.6.0-test1 ACPI minor? proc problems.
To: linux-kernel@vger.kernel.org
Date: Sun, 20 Jul 2003 15:57:27 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While beating on 2.6.0-test1, the only issue I've seen so far is:

cd /proc/
while true
do
find [^0-9k]* -exec wc \{} \; &
sleep 1
done

Causes some ACPI proc errors to be logged in syslog.
(bogus dates)


Mar  9 15:31:54 darkstar kernel:  dswload-0269: *** Error: Looking up [BUFF] in
namespace, AE_ALREADY_EXISTS
Mar  9 15:31:54 darkstar kernel:  psparse-0589 [1394] ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
Mar  9 15:31:54 darkstar kernel:  psparse-1121: *** Error: Method execution failed [\_SB_.BAT1._BIF] (Node cbf285c8), AE_ALREADY_EXISTS
Mar  9 15:31:54 darkstar kernel:  dswload-0269: *** Error: Looking up [BUFF] in
namespace, AE_ALREADY_EXISTS
Mar  9 15:31:54 darkstar kernel:  psparse-0589 [1394] ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
Mar  9 15:31:54 darkstar kernel:  psparse-1121: *** Error: Method execution failed [\_SB_.BAT1._BIF] (Node cbf285c8), AE_ALREADY_EXISTS
Mar  9 15:32:22 darkstar kernel:  dswload-0269: *** Error: Looking up [BUFF] in
namespace, AE_ALREADY_EXISTS
Mar  9 15:32:22 darkstar kernel:  psparse-0589 [1801] ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
Mar  9 15:32:22 darkstar kernel:  psparse-1121: *** Error: Method execution failed [\_SB_.BAT1._BIF] (Node cbf285c8), AE_ALREADY_EXISTS
Mar  9 15:32:22 darkstar kernel:  dswload-0269: *** Error: Looking up [BUFF] in
namespace, AE_ALREADY_EXISTS
Mar  9 15:32:22 darkstar kernel:  psparse-0589 [1801] ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS

Hmm, maybe it's not so trivial, when I went to copy the .config over from the
affected machine onto this one, to post, nfs locked up. (may of course
be unrelated)

If the .config / /proc/acpi/* is needed, then I'll send that on request.

