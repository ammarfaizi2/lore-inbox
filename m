Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTLAWTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLAWTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:19:21 -0500
Received: from mail.g-housing.de ([62.75.136.201]:10202 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264241AbTLAWTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:19:17 -0500
Message-ID: <3FCBBE63.4000907@g-house.de>
Date: Mon, 01 Dec 2003 23:19:15 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: rpc.statd[455]: recv_rply: can't decode RPC message!
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i noticed *lots* of the following messages in my system log:

prinz rpc.statd[455]: recv_rply: can't decode RPC message!
prinz rpc.statd[455]: recv_rply: can't decode RPC message!
prinz rpc.statd[455]: recv_rply: can't decode RPC message!
prinz rpc.statd[455]: recv_rply: can't decode RPC message!

(yes, and so on). it's not flooding the log, but constantly filling it up.

this client is running Debian GNU/Linux (unstable) on i386.

nfs-common and nfs-kernel-server is both 1.0.6-1
(server is Debian GNU/Linux (unstable) on ppc32, not any busier than 
before. kernel on the server is 2.4.23)

i noticed the messages on the client firtst with 2.6.0-test11, they did 
not occur on any former kernelversions. however, the changelog to 
-test11 does not reveal any nfs-related changes.


nfs-utils-1.0.6.orig/utils/statd/rmtcall.c  says at line 227:

if (!xdr_replymsg(xdrs, &mesg)) {
                 note(N_WARNING, "recv_rply: can't decode RPC message!\n");
                 goto done;
         }

any hints?

Thank you,
Christian.

-- 
BOFH excuse #254:

Interference from lunar radiation

