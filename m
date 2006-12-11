Return-Path: <linux-kernel-owner+w=401wt.eu-S936971AbWLKQJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936971AbWLKQJp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936965AbWLKQJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:09:44 -0500
Received: from web32606.mail.mud.yahoo.com ([68.142.207.233]:45983 "HELO
	web32606.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S936971AbWLKQJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:09:43 -0500
X-YMail-OSG: sbrhnokVM1nfZkYgGF3qakxxxCsc4oBTRJuBF9me_0kPlfOo29ji4rQy5EWk1HVXvvCj.yLuMGY_OCNzEHX0Pg28Y6iQu72hDpeT210Pt8b_MuUQoRgRsg--
X-RocketYMMF: knobi.rm
Date: Mon, 11 Dec 2006 08:09:42 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: [2.6.19] NFS: server error: fileid changed
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <751508.31195.qm@web32606.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, [please CC me, as I am not subscribed]

 after updating a RHEL4 box (EM64T based) to a plain 2.6.19 kernel, we
are seeing repeated occurences of the following messages (about every
45-50 minutes).

 It is always the same server (a NetApp filer, mounted via the
user-space automounter "amd") and the expected/got numbers seem to
repeat.

 Is there a  way to find out which files are involved? Nothing seems to
be obviously breaking, but I do not like to get my logfiles filled up. 

[ 9337.747546] NFS: server nvgm022 error: fileid changed
[ 9337.747549] fsid 0:25: expected fileid 0x7a6f3d, got 0x65be80
[ 9338.020427] NFS: server nvgm022 error: fileid changed
[ 9338.020430] fsid 0:25: expected fileid 0x15f5d7c, got 0x9f9900
[ 9338.070147] NFS: server nvgm022 error: fileid changed
[ 9338.070150] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
[ 9338.338896] NFS: server nvgm022 error: fileid changed
[ 9338.338899] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
[ 9338.370207] NFS: server nvgm022 error: fileid changed
[ 9338.370210] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
[ 9338.634437] NFS: server nvgm022 error: fileid changed
[ 9338.634439] fsid 0:25: expected fileid 0x7a6f3d, got 0x22070e
[ 9338.698383] NFS: server nvgm022 error: fileid changed
[ 9338.698385] fsid 0:25: expected fileid 0x7a6f3d, got 0x352777
[ 9338.949952] NFS: server nvgm022 error: fileid changed
[ 9338.949954] fsid 0:25: expected fileid 0x15f5d7c, got 0x5988c4
[ 9339.042473] NFS: server nvgm022 error: fileid changed
[ 9339.042476] fsid 0:25: expected fileid 0x7a6f3d, got 0x9f9900
[ 9339.267338] NFS: server nvgm022 error: fileid changed
[ 9339.267341] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
[ 9339.309921] NFS: server nvgm022 error: fileid changed
[ 9339.309923] fsid 0:25: expected fileid 0x15f5d7c, got 0x65be80
[ 9339.405146] NFS: server nvgm022 error: fileid changed
[ 9339.405149] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
[ 9339.433816] NFS: server nvgm022 error: fileid changed
[ 9339.433819] fsid 0:25: expected fileid 0x15f5d7c, got 0x65be80
[ 9340.149325] NFS: server nvgm022 error: fileid changed
[ 9340.149328] fsid 0:25: expected fileid 0x7a6f3d, got 0x19bc55
[ 9340.173278] NFS: server nvgm022 error: fileid changed
[ 9340.173281] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
[ 9340.324517] NFS: server nvgm022 error: fileid changed
[ 9340.324520] fsid 0:25: expected fileid 0x15f5d7c, got 0x11c9001

Thanks
Martin


------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
