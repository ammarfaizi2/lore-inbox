Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUEYTrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUEYTrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbUEYTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:46:31 -0400
Received: from [82.228.82.76] ([82.228.82.76]:37874 "EHLO
	paperstreet.colino.net") by vger.kernel.org with ESMTP
	id S265082AbUEYTpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:45:20 -0400
Date: Tue, 25 May 2004 21:45:04 +0200
From: Colin Leroy <colin@colino.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2.6.7-rc1) ADB driver fails to create /dev/adb
Message-Id: <20040525214504.377f3f12@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.10claws67.4 (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__25_May_2004_21_45_04_+0200_uxALcE.KhyFP/kfC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__25_May_2004_21_45_04_+0200_uxALcE.KhyFP/kfC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, 

adb driver in 2.6.7-rc1 fails to create /dev/adb (noticed because
pbbuttonsd complains and doesn't work).

I looked at the differences with 2.6.6's driver, and saw that the
devfs bit was removed. Was there a reason for that, apart the fact that
devfs is obsolete ?

Here's a patch that restores previous behaviour. (I bothered because I
noticed lots of other drivers still using devfs_mk_cdev() and I think
it should stay here for a bit more).

hth,
-- 
Colin


--Multipart=_Tue__25_May_2004_21_45_04_+0200_uxALcE.KhyFP/kfC
Content-Type: application/octet-stream;
 name="adb.c.patch"
Content-Disposition: attachment;
 filename="adb.c.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvbWFjaW50b3NoL2FkYi5jLm9yaWcJMjAwNC0wNS0yNSAyMTowODoxMC43Mzg0
ODkzMDQgKzAyMDAKKysrIGRyaXZlcnMvbWFjaW50b3NoL2FkYi5jCTIwMDQtMDUtMjUgMjE6Mjg6
NTQuMTYxNDYwMjgwICswMjAwCkBAIC04OTgsNiArODk4LDkgQEAKIHsKIAlpZiAocmVnaXN0ZXJf
Y2hyZGV2KEFEQl9NQUpPUiwgImFkYiIsICZhZGJfZm9wcykpIHsKIAkJcHJpbnRrKEtFUk5fRVJS
ICJhZGI6IHVuYWJsZSB0byBnZXQgbWFqb3IgJWRcbiIsIEFEQl9NQUpPUik7CisJfSBlbHNlIGlm
IChkZXZmc19ta19jZGV2KE1LREVWKEFEQl9NQUpPUiwgMCksCisJCQkJIFNfSUZDSFIgfCBTX0lS
VVNSIHwgU19JV1VTUiwgImFkYiIpKSB7CisJCXByaW50ayhLRVJOX0VSUiAiYWRiOiB1bmFibGUg
dG8gbWFrZSBkZXYgdmlhIGRldmZzXG4iKTsKIAkJcmV0dXJuOwogCX0KIAlhZGJfZGV2X2NsYXNz
ID0gY2xhc3Nfc2ltcGxlX2NyZWF0ZShUSElTX01PRFVMRSwgImFkYiIpOwo=

--Multipart=_Tue__25_May_2004_21_45_04_+0200_uxALcE.KhyFP/kfC--
