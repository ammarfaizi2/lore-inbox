Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVLVEwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVLVEwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVLVEwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:52:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38352 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965105AbVLVEvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:55 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 34/36] m68k: dmasound __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQk-0004u5-PB@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135214694 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 sound/oss/dmasound/dmasound_atari.c |   94 ++++++++++++++++++-----------------
 sound/oss/dmasound/dmasound_paula.c |    8 +--
 sound/oss/dmasound/dmasound_q40.c   |   18 +++----
 3 files changed, 60 insertions(+), 60 deletions(-)

38b6e13cc8547bac6c7bca7d3ab43ef7c4035adf
diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
index b747e77..dc31373 100644
--- a/sound/oss/dmasound/dmasound_atari.c
+++ b/sound/oss/dmasound/dmasound_atari.c
@@ -67,46 +67,46 @@ static int expand_data;	/* Data for expa
  * ++geert: split in even more functions (one per format)
  */
 
-static ssize_t ata_ct_law(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_law(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft);
-static ssize_t ata_ct_s8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_s8(const u_char __user *userPtr, size_t userCount,
 			 u_char frame[], ssize_t *frameUsed,
 			 ssize_t frameLeft);
-static ssize_t ata_ct_u8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_u8(const u_char __user *userPtr, size_t userCount,
 			 u_char frame[], ssize_t *frameUsed,
 			 ssize_t frameLeft);
-static ssize_t ata_ct_s16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_s16be(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft);
-static ssize_t ata_ct_u16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_u16be(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft);
-static ssize_t ata_ct_s16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_s16le(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft);
-static ssize_t ata_ct_u16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_u16le(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft);
-static ssize_t ata_ctx_law(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_law(const u_char __user *userPtr, size_t userCount,
 			   u_char frame[], ssize_t *frameUsed,
 			   ssize_t frameLeft);
-static ssize_t ata_ctx_s8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_s8(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft);
-static ssize_t ata_ctx_u8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_u8(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft);
-static ssize_t ata_ctx_s16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_s16be(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft);
-static ssize_t ata_ctx_u16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_u16be(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft);
-static ssize_t ata_ctx_s16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_s16le(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft);
-static ssize_t ata_ctx_u16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_u16le(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft);
 
@@ -151,7 +151,7 @@ static int FalconStateInfo(char *buffer,
 /*** Translations ************************************************************/
 
 
-static ssize_t ata_ct_law(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_law(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft)
 {
@@ -176,7 +176,7 @@ static ssize_t ata_ct_law(const u_char *
 }
 
 
-static ssize_t ata_ct_s8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_s8(const u_char __user *userPtr, size_t userCount,
 			 u_char frame[], ssize_t *frameUsed,
 			 ssize_t frameLeft)
 {
@@ -194,7 +194,7 @@ static ssize_t ata_ct_s8(const u_char *u
 }
 
 
-static ssize_t ata_ct_u8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_u8(const u_char __user *userPtr, size_t userCount,
 			 u_char frame[], ssize_t *frameUsed,
 			 ssize_t frameLeft)
 {
@@ -217,7 +217,7 @@ static ssize_t ata_ct_u8(const u_char *u
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, (u_short *)userPtr))
+			if (get_user(data, (u_short __user *)userPtr))
 				return -EFAULT;
 			userPtr += 2;
 			*p++ = data ^ 0x8080;
@@ -229,7 +229,7 @@ static ssize_t ata_ct_u8(const u_char *u
 }
 
 
-static ssize_t ata_ct_s16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_s16be(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft)
 {
@@ -241,7 +241,7 @@ static ssize_t ata_ct_s16be(const u_char
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, (u_short *)userPtr))
+			if (get_user(data, (u_short __user *)userPtr))
 				return -EFAULT;
 			userPtr += 2;
 			*p++ = data;
@@ -261,7 +261,7 @@ static ssize_t ata_ct_s16be(const u_char
 }
 
 
-static ssize_t ata_ct_u16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_u16be(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft)
 {
@@ -273,7 +273,7 @@ static ssize_t ata_ct_u16be(const u_char
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, (u_short *)userPtr))
+			if (get_user(data, (u_short __user *)userPtr))
 				return -EFAULT;
 			userPtr += 2;
 			data ^= 0x8000;
@@ -287,8 +287,8 @@ static ssize_t ata_ct_u16be(const u_char
 		count = min_t(unsigned long, userCount, frameLeft)>>2;
 		used = count*4;
 		while (count > 0) {
-			u_long data;
-			if (get_user(data, (u_int *)userPtr))
+			u_int data;
+			if (get_user(data, (u_int __user *)userPtr))
 				return -EFAULT;
 			userPtr += 4;
 			*p++ = data ^ 0x80008000;
@@ -300,7 +300,7 @@ static ssize_t ata_ct_u16be(const u_char
 }
 
 
-static ssize_t ata_ct_s16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_s16le(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft)
 {
@@ -313,7 +313,7 @@ static ssize_t ata_ct_s16le(const u_char
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, (u_short *)userPtr))
+			if (get_user(data, (u_short __user *)userPtr))
 				return -EFAULT;
 			userPtr += 2;
 			data = le2be16(data);
@@ -328,7 +328,7 @@ static ssize_t ata_ct_s16le(const u_char
 		used = count*4;
 		while (count > 0) {
 			u_long data;
-			if (get_user(data, (u_int *)userPtr))
+			if (get_user(data, (u_int __user *)userPtr))
 				return -EFAULT;
 			userPtr += 4;
 			data = le2be16dbl(data);
@@ -341,7 +341,7 @@ static ssize_t ata_ct_s16le(const u_char
 }
 
 
-static ssize_t ata_ct_u16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ct_u16le(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft)
 {
@@ -354,7 +354,7 @@ static ssize_t ata_ct_u16le(const u_char
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, (u_short *)userPtr))
+			if (get_user(data, (u_short __user *)userPtr))
 				return -EFAULT;
 			userPtr += 2;
 			data = le2be16(data) ^ 0x8000;
@@ -368,7 +368,7 @@ static ssize_t ata_ct_u16le(const u_char
 		used = count;
 		while (count > 0) {
 			u_long data;
-			if (get_user(data, (u_int *)userPtr))
+			if (get_user(data, (u_int __user *)userPtr))
 				return -EFAULT;
 			userPtr += 4;
 			data = le2be16dbl(data) ^ 0x80008000;
@@ -381,7 +381,7 @@ static ssize_t ata_ct_u16le(const u_char
 }
 
 
-static ssize_t ata_ctx_law(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_law(const u_char __user *userPtr, size_t userCount,
 			   u_char frame[], ssize_t *frameUsed,
 			   ssize_t frameLeft)
 {
@@ -443,7 +443,7 @@ static ssize_t ata_ctx_law(const u_char 
 }
 
 
-static ssize_t ata_ctx_s8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_s8(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft)
 {
@@ -478,7 +478,7 @@ static ssize_t ata_ctx_s8(const u_char *
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, (u_short *)userPtr))
+				if (get_user(data, (u_short __user *)userPtr))
 					return -EFAULT;
 				userPtr += 2;
 				userCount -= 2;
@@ -497,7 +497,7 @@ static ssize_t ata_ctx_s8(const u_char *
 }
 
 
-static ssize_t ata_ctx_u8(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_u8(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft)
 {
@@ -533,7 +533,7 @@ static ssize_t ata_ctx_u8(const u_char *
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, (u_short *)userPtr))
+				if (get_user(data, (u_short __user *)userPtr))
 					return -EFAULT;
 				userPtr += 2;
 				data ^= 0x8080;
@@ -553,7 +553,7 @@ static ssize_t ata_ctx_u8(const u_char *
 }
 
 
-static ssize_t ata_ctx_s16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_s16be(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft)
 {
@@ -571,7 +571,7 @@ static ssize_t ata_ctx_s16be(const u_cha
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, (u_short *)userPtr))
+				if (get_user(data, (u_short __user *)userPtr))
 					return -EFAULT;
 				userPtr += 2;
 				userCount -= 2;
@@ -590,7 +590,7 @@ static ssize_t ata_ctx_s16be(const u_cha
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, (u_int *)userPtr))
+				if (get_user(data, (u_int __user *)userPtr))
 					return -EFAULT;
 				userPtr += 4;
 				userCount -= 4;
@@ -609,7 +609,7 @@ static ssize_t ata_ctx_s16be(const u_cha
 }
 
 
-static ssize_t ata_ctx_u16be(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_u16be(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft)
 {
@@ -627,7 +627,7 @@ static ssize_t ata_ctx_u16be(const u_cha
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, (u_short *)userPtr))
+				if (get_user(data, (u_short __user *)userPtr))
 					return -EFAULT;
 				userPtr += 2;
 				data ^= 0x8000;
@@ -647,7 +647,7 @@ static ssize_t ata_ctx_u16be(const u_cha
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, (u_int *)userPtr))
+				if (get_user(data, (u_int __user *)userPtr))
 					return -EFAULT;
 				userPtr += 4;
 				data ^= 0x80008000;
@@ -667,7 +667,7 @@ static ssize_t ata_ctx_u16be(const u_cha
 }
 
 
-static ssize_t ata_ctx_s16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_s16le(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft)
 {
@@ -685,7 +685,7 @@ static ssize_t ata_ctx_s16le(const u_cha
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, (u_short *)userPtr))
+				if (get_user(data, (u_short __user *)userPtr))
 					return -EFAULT;
 				userPtr += 2;
 				data = le2be16(data);
@@ -705,7 +705,7 @@ static ssize_t ata_ctx_s16le(const u_cha
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, (u_int *)userPtr))
+				if (get_user(data, (u_int __user *)userPtr))
 					return -EFAULT;
 				userPtr += 4;
 				data = le2be16dbl(data);
@@ -725,7 +725,7 @@ static ssize_t ata_ctx_s16le(const u_cha
 }
 
 
-static ssize_t ata_ctx_u16le(const u_char *userPtr, size_t userCount,
+static ssize_t ata_ctx_u16le(const u_char __user *userPtr, size_t userCount,
 			     u_char frame[], ssize_t *frameUsed,
 			     ssize_t frameLeft)
 {
@@ -743,7 +743,7 @@ static ssize_t ata_ctx_u16le(const u_cha
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, (u_short *)userPtr))
+				if (get_user(data, (u_short __user *)userPtr))
 					return -EFAULT;
 				userPtr += 2;
 				data = le2be16(data) ^ 0x8000;
@@ -763,7 +763,7 @@ static ssize_t ata_ctx_u16le(const u_cha
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, (u_int *)userPtr))
+				if (get_user(data, (u_int __user *)userPtr))
 					return -EFAULT;
 				userPtr += 4;
 				data = le2be16dbl(data) ^ 0x80008000;
diff --git a/sound/oss/dmasound/dmasound_paula.c b/sound/oss/dmasound/dmasound_paula.c
index 5417815..494070a 100644
--- a/sound/oss/dmasound/dmasound_paula.c
+++ b/sound/oss/dmasound/dmasound_paula.c
@@ -157,7 +157,7 @@ static int AmiStateInfo(char *buffer, si
      *  Native format
      */
 
-static ssize_t ami_ct_s8(const u_char *userPtr, size_t userCount,
+static ssize_t ami_ct_s8(const u_char __user *userPtr, size_t userCount,
 			 u_char frame[], ssize_t *frameUsed, ssize_t frameLeft)
 {
 	ssize_t count, used;
@@ -190,7 +190,7 @@ static ssize_t ami_ct_s8(const u_char *u
      */
 
 #define GENERATE_AMI_CT8(funcname, convsample)				\
-static ssize_t funcname(const u_char *userPtr, size_t userCount,	\
+static ssize_t funcname(const u_char __user *userPtr, size_t userCount,	\
 			u_char frame[], ssize_t *frameUsed,		\
 			ssize_t frameLeft)				\
 {									\
@@ -241,11 +241,11 @@ GENERATE_AMI_CT8(ami_ct_u8, AMI_CT_U8)
      */
 
 #define GENERATE_AMI_CT_16(funcname, convsample)			\
-static ssize_t funcname(const u_char *userPtr, size_t userCount,	\
+static ssize_t funcname(const u_char __user *userPtr, size_t userCount,	\
 			u_char frame[], ssize_t *frameUsed,		\
 			ssize_t frameLeft)				\
 {									\
-	const u_short *ptr = (const u_short *)userPtr;			\
+	const u_short __user *ptr = (const u_short __user *)userPtr;	\
 	ssize_t count, used;						\
 	u_short data;							\
 									\
diff --git a/sound/oss/dmasound/dmasound_q40.c b/sound/oss/dmasound/dmasound_q40.c
index 1ddaa62..e2081f3 100644
--- a/sound/oss/dmasound/dmasound_q40.c
+++ b/sound/oss/dmasound/dmasound_q40.c
@@ -58,7 +58,7 @@ static void Q40Interrupt(void);
 
 
 /* userCount, frameUsed, frameLeft == byte counts */
-static ssize_t q40_ct_law(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ct_law(const u_char __user *userPtr, size_t userCount,
 			   u_char frame[], ssize_t *frameUsed,
 			   ssize_t frameLeft)
 {
@@ -79,7 +79,7 @@ static ssize_t q40_ct_law(const u_char *
 }
 
 
-static ssize_t q40_ct_s8(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ct_s8(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft)
 {
@@ -98,7 +98,7 @@ static ssize_t q40_ct_s8(const u_char *u
 	return used;
 }
 
-static ssize_t q40_ct_u8(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ct_u8(const u_char __user *userPtr, size_t userCount,
 			  u_char frame[], ssize_t *frameUsed,
 			  ssize_t frameLeft)
 {
@@ -114,7 +114,7 @@ static ssize_t q40_ct_u8(const u_char *u
 
 
 /* a bit too complicated to optimise right now ..*/
-static ssize_t q40_ctx_law(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ctx_law(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft)
 {
@@ -152,7 +152,7 @@ static ssize_t q40_ctx_law(const u_char 
 }
 
 
-static ssize_t q40_ctx_s8(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ctx_s8(const u_char __user *userPtr, size_t userCount,
 			   u_char frame[], ssize_t *frameUsed,
 			   ssize_t frameLeft)
 {
@@ -189,7 +189,7 @@ static ssize_t q40_ctx_s8(const u_char *
 }
 
 
-static ssize_t q40_ctx_u8(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ctx_u8(const u_char __user *userPtr, size_t userCount,
 			   u_char frame[], ssize_t *frameUsed,
 			   ssize_t frameLeft)
 {
@@ -224,7 +224,7 @@ static ssize_t q40_ctx_u8(const u_char *
 }
 
 /* compressing versions */
-static ssize_t q40_ctc_law(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ctc_law(const u_char __user *userPtr, size_t userCount,
 			    u_char frame[], ssize_t *frameUsed,
 			    ssize_t frameLeft)
 {
@@ -265,7 +265,7 @@ static ssize_t q40_ctc_law(const u_char 
 }
 
 
-static ssize_t q40_ctc_s8(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ctc_s8(const u_char __user *userPtr, size_t userCount,
 			   u_char frame[], ssize_t *frameUsed,
 			   ssize_t frameLeft)
 {
@@ -304,7 +304,7 @@ static ssize_t q40_ctc_s8(const u_char *
 }
 
 
-static ssize_t q40_ctc_u8(const u_char *userPtr, size_t userCount,
+static ssize_t q40_ctc_u8(const u_char __user *userPtr, size_t userCount,
 			   u_char frame[], ssize_t *frameUsed,
 			   ssize_t frameLeft)
 {
-- 
0.99.9.GIT

