Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbULNVNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbULNVNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbULNVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:13:21 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:3267 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261661AbULNVNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:13:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=BPv2E/BnQN0TesRMjhLLMiTU2u9YfbZuKM51vXDi00k875hzyWi85OcoHJ9EWy6sc3d/0TgrX2d8yi2vRHvnXOy9bG7ER0TLGRSEpt4/kwv6eMBYR7jfkaRYwZweDRKsacLNz/wAodrX7A2NW5pwNP7QEk8nBIgm457SdUnHiHk=
Message-ID: <aec7e5c304121413135a088aaf@mail.gmail.com>
Date: Tue, 14 Dec 2004 22:13:17 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] aty128fb: do not release unrequested range
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_425_2295226.1103058797071"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_425_2295226.1103058797071
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The aty128fb driver in 2.6.10-rc3 tries to release an unrequested
range during driver unload. This results in the following printout on
my Apple G4 Cube:

Trying to free nonexistent resource <00802400-008024ff>

The remedy is simple - do not release the unrequested range.

/ magnus

------=_Part_425_2295226.1103058797071
Content-Type: application/octet-stream; name="linux-2.6.10-rc3-aty128fb_norelease.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.10-rc3-aty128fb_norelease.patch"

LS0tIGxpbnV4LTIuNi4xMC1yYzMvZHJpdmVycy92aWRlby9hdHkvYXR5MTI4ZmIuYwkyMDA0LTEy
LTAzIDE1OjAwOjU0LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjEwLXJjMy1hdHkxMjhm
Yl9ub3JlbGVhc2UvZHJpdmVycy92aWRlby9hdHkvYXR5MTI4ZmIuYwkyMDA0LTEyLTEyIDE2OjQ1
OjQ3LjEyMDQyMzc1MiArMDEwMApAQCAtMjAxNiw4ICsyMDE2LDYgQEAKIAogCXJlbGVhc2VfbWVt
X3JlZ2lvbihwY2lfcmVzb3VyY2Vfc3RhcnQocGRldiwgMCksCiAJCQkgICBwY2lfcmVzb3VyY2Vf
bGVuKHBkZXYsIDApKTsKLQlyZWxlYXNlX21lbV9yZWdpb24ocGNpX3Jlc291cmNlX3N0YXJ0KHBk
ZXYsIDEpLAotCQkJICAgcGNpX3Jlc291cmNlX2xlbihwZGV2LCAxKSk7CiAJcmVsZWFzZV9tZW1f
cmVnaW9uKHBjaV9yZXNvdXJjZV9zdGFydChwZGV2LCAyKSwKIAkJCSAgIHBjaV9yZXNvdXJjZV9s
ZW4ocGRldiwgMikpOwogCWZyYW1lYnVmZmVyX3JlbGVhc2UoaW5mbyk7Cg==
------=_Part_425_2295226.1103058797071--
