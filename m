Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUHIMQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUHIMQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUHIMIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:08:11 -0400
Received: from main.gmane.org ([80.91.224.249]:17039 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266512AbUHIMH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:07:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Mon, 09 Aug 2004 14:07:25 +0200
Message-ID: <yw1xd6204irm.fsf@kth.se>
References: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de> <41175798.7000406@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:yYDCi0u+VdfzO1i/nj8YUfz+gFA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@hist.no> writes:

> If you want to provide a multi-platform app with an acceptable user
> interface, then you have to cope with the different adressing
> schemes.  If that is too much work, consider taking patches from
> volunteers similiar to how the linux kernel and many other big
> projects are managed.  I am sure you can get someone to write
> "perfect" support for /dev/XYZ on linux for you, if you're willing
> to apply such a patch.

How's this for a start?

--- libscg/scsi-linux-sg.c~     2004-01-14 18:54:01 +01:00
+++ libscg/scsi-linux-sg.c      2004-08-09 14:05:03 +02:00
@@ -476,10 +476,6 @@
                        b = device[7] - 'a';
                        if (b < 0 || b > 25)
                                b = -1;
-               }
-               if (scgp->overbose) {
-                       js_fprintf((FILE *)scgp->errfile,
-                       "Warning: Open by 'devname' is unintentional and not supported.\n");
                }
                                        /* O_NONBLOCK is dangerous */
                f = open(device, O_RDWR | O_NONBLOCK);

-- 
Måns Rullgård
mru@kth.se

