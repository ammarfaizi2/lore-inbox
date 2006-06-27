Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030661AbWF0Eiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030661AbWF0Eiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030666AbWF0Eim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:42 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32726 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030662AbWF0Eii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:38 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/12] [Suspend2] Encryption proc entries.
Date: Tue, 27 Jun 2006 14:38:37 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043836.14437.35082.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add data for the encryption related proc entries.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   82 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 1664b82..4e309e3 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -400,3 +400,85 @@ static void suspend_encrypt_load_config_
 	}
 	return;
 }
+
+/*
+ * data for our proc entries.
+ */
+static struct suspend_proc_data proc_params[] = {
+{
+	.filename			= "encryptor",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_STRING,
+	.data = {
+		.string = {
+			.variable	= suspend_encryptor_name,
+			.max_length	= 31,
+		}
+	},
+},
+
+{
+	.filename			= "encryption_mode",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_INTEGER,
+	.data = {
+		.integer = {
+			.variable	= &suspend_encryptor_mode,
+			.minimum	= 0,
+			.maximum	= 3,
+		}
+	}
+},
+
+{
+	.filename			= "encryption_save_key_and_iv",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_INTEGER,
+	.data = {
+		.integer = {
+			.variable	= &suspend_encryptor_save_key_and_iv,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	}
+},
+
+{
+	.filename			= "encryption_key",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_STRING,
+	.data = {
+		.string = {
+			.variable	= suspend_encryptor_key,
+			.max_length	= 255,
+		}
+	}
+},
+
+{
+	.filename			= "encryption_iv",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_STRING,
+	.data = {
+		.string = {
+			.variable	= suspend_encryptor_iv,
+			.max_length	= 255,
+		}
+	}
+},
+
+{
+	.filename			= "disable_encryption",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_INTEGER,
+	.data = {
+		.integer = {
+			.variable	= &suspend_encryption_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	}
+},
+	
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
