Return-Path: <linux-kernel-owner+w=401wt.eu-S964952AbXADP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbXADP6H (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbXADP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:58:07 -0500
Received: from www.sf-tec.de ([62.27.20.187]:47077 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964950AbXADP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:58:05 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add const for time{spec,val}_compare arguments
Date: Thu, 4 Jan 2007 16:59:12 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701041659.13532.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The arguments are really const. Mark them const to allow these functions
being called from places where the arguments are const without getting
useless compiler warnings.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit aa6af3ef5a9708b1b81aa4b6b0d30c578ac1b29c
tree 157e65f05bcb7aac859186c944573f5d40935564
parent 213bcc9bc614154948b6f83cbb872ea046557598
author Rolf Eike Beer <eike-kernel@sf-tec.de> Wed, 13 Dec 2006 09:46:58 +0100
committer Rolf Eike Beer <eike-kernel@sf-tec.de> Wed, 13 Dec 2006 09:46:58 +0100

 include/linux/time.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index a5b7399..55cee17 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -46,7 +46,7 @@ static inline int timespec_equal(struct timespec *a, struct timespec *b)
  * lhs == rhs: return 0
  * lhs > rhs:  return >0
  */
-static inline int timespec_compare(struct timespec *lhs, struct timespec *rhs)
+static inline int timespec_compare(const struct timespec *lhs, const struct timespec *rhs)
 {
 	if (lhs->tv_sec < rhs->tv_sec)
 		return -1;
@@ -55,7 +55,7 @@ static inline int timespec_compare(struct timespec *lhs, struct timespec *rhs)
 	return lhs->tv_nsec - rhs->tv_nsec;
 }
 
-static inline int timeval_compare(struct timeval *lhs, struct timeval *rhs)
+static inline int timeval_compare(const struct timeval *lhs, const struct timeval *rhs)
 {
 	if (lhs->tv_sec < rhs->tv_sec)
 		return -1;
