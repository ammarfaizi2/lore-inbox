Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTBSXnx>; Wed, 19 Feb 2003 18:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTBSXkt>; Wed, 19 Feb 2003 18:40:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35858 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262808AbTBSXkV>;
	Wed, 19 Feb 2003 18:40:21 -0500
Date: Wed, 19 Feb 2003 15:43:25 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.62
Message-ID: <20030219234325.GI18590@kroah.com>
References: <20030219234140.GA18590@kroah.com> <20030219234203.GB18590@kroah.com> <20030219234216.GC18590@kroah.com> <20030219234228.GD18590@kroah.com> <20030219234239.GE18590@kroah.com> <20030219234250.GF18590@kroah.com> <20030219234302.GG18590@kroah.com> <20030219234314.GH18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219234314.GH18590@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.994, 2003/02/19 14:58:39-08:00, greg@kroah.com

LSM: fix merge where we lost a prototype in security.h


diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Wed Feb 19 15:38:30 2003
+++ b/include/linux/security.h	Wed Feb 19 15:38:30 2003
@@ -48,6 +48,7 @@
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_kmod_set_label (void);
 extern void cap_task_reparent_to_init (struct task_struct *p);
+extern int cap_syslog (int type);
 
 static inline int cap_netlink_send (struct sk_buff *skb)
 {
