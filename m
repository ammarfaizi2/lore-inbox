Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVLEO5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVLEO5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVLEO5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:57:34 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:46252 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932426AbVLEO5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:57:33 -0500
Subject: [patch 2/2] selinux:  ARRAY_SIZE cleanups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>
Cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       Tobias Klauser <tklauser@nuerscht.ch>, Nicolas Kaiser <nikai@nikai.net>
In-Reply-To: <1133793642.20862.61.camel@moss-spartans.epoch.ncsc.mil>
References: <1133793642.20862.61.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 05 Dec 2005 10:03:56 -0500
Message-Id: <1133795036.20862.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>

Further ARRAY_SIZE cleanups under security/selinux.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/ss/avtab.c    |    2 +-
 security/selinux/ss/policydb.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -X /home/sds/dontdiff -rup a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
--- a/security/selinux/ss/avtab.c	2005-10-27 20:02:08.000000000 -0400
+++ b/security/selinux/ss/avtab.c	2005-12-05 09:12:00.000000000 -0500
@@ -359,7 +359,7 @@ int avtab_read_item(void *fp, u32 vers, 
 			return -1;
 		}
 
-		for (i = 0; i < sizeof(spec_order)/sizeof(u16); i++) {
+		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
 				key.specified = spec_order[i] | enabled;
 				datum.data = le32_to_cpu(buf32[items++]);
diff -X /home/sds/dontdiff -rup a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
--- a/security/selinux/ss/policydb.c	2005-12-05 09:06:40.000000000 -0500
+++ b/security/selinux/ss/policydb.c	2005-12-05 09:12:00.000000000 -0500
@@ -103,7 +103,7 @@ static struct policydb_compat_info *poli
 	int i;
 	struct policydb_compat_info *info = NULL;
 
-	for (i = 0; i < sizeof(policydb_compat)/sizeof(*info); i++) {
+	for (i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
 		if (policydb_compat[i].version == version) {
 			info = &policydb_compat[i];
 			break;

-- 
Stephen Smalley
National Security Agency

