Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758154AbWK0MqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154AbWK0MqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758157AbWK0MqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:46:07 -0500
Received: from web32615.mail.mud.yahoo.com ([68.142.207.242]:7773 "HELO
	web32615.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1758154AbWK0Mp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:45:57 -0500
X-YMail-OSG: zgJ.VkUVM1kRbL36dkOD6oJDy6nNFVEDt9lXo33XVHDfj1fXriZkuQBDuFQiDcw38A--
X-RocketYMMF: knobi.rm
Date: Mon, 27 Nov 2006 04:45:55 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: File-locking problems with RHEL4 kernel (2.6.9-42.0.3.ELsmp) under high load
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <892617.7429.qm@web32615.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 first of all, yes - I know that this kernel is very old and it is not
an official LKML kernel. No need to tell me, no need to waste bandwidth
by telling me :-) I just post here, because I got no response
"elsewhere".

 Second - please CC me on any reply, as I am not subscribed.

 OK. Here is the problem. Said RHEL4 kernel seems to have problems with
file-locking when the system is under high, likely network related,
load. The symptoms are things using file locking (rpm, the user-space
automounter amd) fail to obtain locks, usually stating timeout
problems.

 The sytem in question is a HP/DL380G4 with dual-single-core EM64T CPUs
and 8GB of Memory. The network interfaces are "tg3". 

 The high load can be triggered by copying three 3 GB files in parallel
from an NFS server (Solaris10, NFS, TCP, 1GBit) to another NFS server
(RHEL4, NFS, TCP, 100 MBit). The measured network performance is OK.
During this operation the systems goes to Loads around/above 10.
Overall responsiveness feels good, but software doing file-locking or
opening a new ssh connection take extremely long.

 So, if anyone has an idea or hint, it will be highly appreciated.

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
