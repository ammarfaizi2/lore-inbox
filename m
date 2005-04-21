Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVDUKdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVDUKdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 06:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVDUKdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 06:33:04 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:24240 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261272AbVDUKdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 06:33:01 -0400
Date: Thu, 21 Apr 2005 12:32:59 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1617591394.20050421123259@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: strange incremental patch size [2.6.12-rc2 to 2.6.12-rc3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are the sizes of rc2 and rc3 patches

# ls -la patch-2.6.12*
-rw-r--r--  1 root src 18011382 Apr  4 18:50 patch-2.6.12-rc2
-rw-r--r--  1 root src 19979854 Apr 21 02:29 patch-2.6.12-rc3

Let us make an incremental patch from rc2 to rc3

# interdiff patch-2.6.12-rc2 patch-2.6.12-rc3 >x

Let us see how big it is.
# ls -ld x
-rw-r--r--  1 root src 37421924 Apr 21 12:28 x

How come interdiff from rc2 (18MB) to rc3 (20MB) gave me
37MB worth of patch-code ? I would expect something about
2MB but 40MB ?

The patching with the incremental patch took very long compared
to other rc2-rc3-type patches, that is how I noticed it.

Regards,
Maciej


