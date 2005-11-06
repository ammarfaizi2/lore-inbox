Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVKFTgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVKFTgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVKFTgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 14:36:47 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:19632 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751188AbVKFTgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 14:36:46 -0500
Date: Sun, 6 Nov 2005 13:41:30 -0500 (EST)
From: Parag Warudkar <root@comcast.net>
X-X-Sender: root@localhost.localdomain
To: panto@intracom.gr
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] FEC_8xx dependency on CONFIG_PPC
Message-ID: <Pine.LNX.4.64.0511061332250.3646@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-834104719-1131302490=:3646"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-834104719-1131302490=:3646
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Just noticed that make allmodconfig breaks on i386 due to the FEC_8xx 
driver.

I don't know much about FEC_8xx but I have a feeling that's because it is 
intended only for PPC boxes.

A simple change to drivers/net/fec_8xx/Kconfig to make it dependent on PPC 
in addition to NET_ETHERNET allows make allmodconfig to build.

Please suggest if the attached patch is Ok.

Parag
--8323328-834104719-1131302490=:3646
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch-fec_8xx-Kconfig
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0511061341300.3646@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=patch-fec_8xx-Kconfig

LS0tIGtlcm5lbC13b3JrLWV4L2RyaXZlcnMvbmV0L2ZlY184eHgvS2NvbmZp
Zy5vcmlnCTIwMDUtMTEtMDYgMTM6MzU6NTMuMDAwMDAwMDAwIC0wNTAwDQor
Kysga2VybmVsLXdvcmstZXgvZHJpdmVycy9uZXQvZmVjXzh4eC9LY29uZmln
CTIwMDUtMTEtMDYgMTM6MzY6MzUuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMSw2
ICsxLDYgQEANCiBjb25maWcgRkVDXzhYWA0KIAl0cmlzdGF0ZSAiTW90b3Jv
bGEgOHh4IEZFQyBkcml2ZXIiDQotCWRlcGVuZHMgb24gTkVUX0VUSEVSTkVU
DQorCWRlcGVuZHMgb24gTkVUX0VUSEVSTkVUICYmIFBQQw0KIAlzZWxlY3Qg
TUlJDQogDQogY29uZmlnIEZFQ184WFhfR0VORVJJQ19QSFkNCg==

--8323328-834104719-1131302490=:3646--
