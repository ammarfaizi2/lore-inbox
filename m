Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317886AbSGWAf7>; Mon, 22 Jul 2002 20:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSGWAf7>; Mon, 22 Jul 2002 20:35:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:7684 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317886AbSGWAfz>;
	Mon, 22 Jul 2002 20:35:55 -0400
Date: Mon, 22 Jul 2002 17:39:05 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723003905.GC660@kroah.com>
References: <20020723003702.GA660@kroah.com> <20020723003806.GB660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723003806.GB660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683   -> 1.683.1.1
#	    security/dummy.c	1.1     -> 1.2    
#	security/capability.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	adam@skullslayer.rod.org	1.683.1.1
# [PATCH] LSM to designated initializers
# 
# Over the last few days there has been discussion on the
# LKML list about converting struct initializers from the
#     field:    val,
# format into
#     .field =  val,
# 
# I have included a patch that will do this for both the
# dummy and capabilities files.
# --------------------------------------------
#
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Mon Jul 22 17:26:07 2002
+++ b/security/capability.c	Mon Jul 22 17:26:07 2002
@@ -387,41 +387,41 @@
 }
 
 static struct security_operations capability_ops = {
-	ptrace:				cap_ptrace,
-	capget:				cap_capget,
-	capset_check:			cap_capset_check,
-	capset_set:			cap_capset_set,
-	capable:			cap_capable,
-	sys_security:			cap_sys_security,
+	.ptrace =			cap_ptrace,
+	.capget =			cap_capget,
+	.capset_check =			cap_capset_check,
+	.capset_set =			cap_capset_set,
+	.capable =			cap_capable,
+	.sys_security =			cap_sys_security,
 	
-	bprm_alloc_security:		cap_bprm_alloc_security,
-	bprm_free_security:		cap_bprm_free_security,
-	bprm_compute_creds:		cap_bprm_compute_creds,
-	bprm_set_security:		cap_bprm_set_security,
-	bprm_check_security:		cap_bprm_check_security,
+	.bprm_alloc_security =		cap_bprm_alloc_security,
+	.bprm_free_security =		cap_bprm_free_security,
+	.bprm_compute_creds =		cap_bprm_compute_creds,
+	.bprm_set_security =		cap_bprm_set_security,
+	.bprm_check_security =		cap_bprm_check_security,
 	
-	task_create:			cap_task_create,
-	task_alloc_security:		cap_task_alloc_security,
-	task_free_security:		cap_task_free_security,
-	task_setuid:			cap_task_setuid,
-	task_post_setuid:		cap_task_post_setuid,
-	task_setgid:			cap_task_setgid,
-	task_setpgid:			cap_task_setpgid,
-	task_getpgid:			cap_task_getpgid,
-	task_getsid:			cap_task_getsid,
-	task_setgroups:			cap_task_setgroups,
-	task_setnice:			cap_task_setnice,
-	task_setrlimit:			cap_task_setrlimit,
-	task_setscheduler:		cap_task_setscheduler,
-	task_getscheduler:		cap_task_getscheduler,
-	task_wait:			cap_task_wait,
-	task_kill:			cap_task_kill,
-	task_prctl:			cap_task_prctl,
-	task_kmod_set_label:		cap_task_kmod_set_label,
-	task_reparent_to_init:		cap_task_reparent_to_init,
+	.task_create =			cap_task_create,
+	.task_alloc_security =		cap_task_alloc_security,
+	.task_free_security =		cap_task_free_security,
+	.task_setuid =			cap_task_setuid,
+	.task_post_setuid =		cap_task_post_setuid,
+	.task_setgid =			cap_task_setgid,
+	.task_setpgid =			cap_task_setpgid,
+	.task_getpgid =			cap_task_getpgid,
+	.task_getsid =			cap_task_getsid,
+	.task_setgroups =		cap_task_setgroups,
+	.task_setnice =			cap_task_setnice,
+	.task_setrlimit =		cap_task_setrlimit,
+	.task_setscheduler =		cap_task_setscheduler,
+	.task_getscheduler =		cap_task_getscheduler,
+	.task_wait =			cap_task_wait,
+	.task_kill =			cap_task_kill,
+	.task_prctl =			cap_task_prctl,
+	.task_kmod_set_label =		cap_task_kmod_set_label,
+	.task_reparent_to_init =	cap_task_reparent_to_init,
 	
-	register_security:		cap_register,
-	unregister_security:		cap_unregister,
+	.register_security =		cap_register,
+	.unregister_security =		cap_unregister,
 };
 
 #if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Mon Jul 22 17:26:07 2002
+++ b/security/dummy.c	Mon Jul 22 17:26:07 2002
@@ -197,40 +197,40 @@
 }
 
 struct security_operations dummy_security_ops = {
-	ptrace:				dummy_ptrace,
-	capget:				dummy_capget,
-	capset_check:			dummy_capset_check,
-	capset_set:			dummy_capset_set,
-	capable:			dummy_capable,
-	sys_security:			dummy_sys_security,
+	.ptrace =			dummy_ptrace,
+	.capget =			dummy_capget,
+	.capset_check =			dummy_capset_check,
+	.capset_set =			dummy_capset_set,
+	.capable =			dummy_capable,
+	.sys_security =			dummy_sys_security,
 	
-	bprm_alloc_security:		dummy_bprm_alloc_security,
-	bprm_free_security:		dummy_bprm_free_security,
-	bprm_compute_creds:		dummy_bprm_compute_creds,
-	bprm_set_security:		dummy_bprm_set_security,
-	bprm_check_security:		dummy_bprm_check_security,
+	.bprm_alloc_security =		dummy_bprm_alloc_security,
+	.bprm_free_security =		dummy_bprm_free_security,
+	.bprm_compute_creds =		dummy_bprm_compute_creds,
+	.bprm_set_security =		dummy_bprm_set_security,
+	.bprm_check_security =		dummy_bprm_check_security,
 
-	task_create:			dummy_task_create,
-	task_alloc_security:		dummy_task_alloc_security,
-	task_free_security:		dummy_task_free_security,
-	task_setuid:			dummy_task_setuid,
-	task_post_setuid:		dummy_task_post_setuid,
-	task_setgid:			dummy_task_setgid,
-	task_setpgid:			dummy_task_setpgid,
-	task_getpgid:			dummy_task_getpgid,
-	task_getsid:			dummy_task_getsid,
-	task_setgroups:			dummy_task_setgroups,
-	task_setnice:			dummy_task_setnice,
-	task_setrlimit:			dummy_task_setrlimit,
-	task_setscheduler:		dummy_task_setscheduler,
-	task_getscheduler:		dummy_task_getscheduler,
-	task_wait:			dummy_task_wait,
-	task_kill:			dummy_task_kill,
-	task_prctl:			dummy_task_prctl,
-	task_kmod_set_label:		dummy_task_kmod_set_label,
-	task_reparent_to_init:		dummy_task_reparent_to_init,
+	.task_create =			dummy_task_create,
+	.task_alloc_security =		dummy_task_alloc_security,
+	.task_free_security =		dummy_task_free_security,
+	.task_setuid =			dummy_task_setuid,
+	.task_post_setuid =		dummy_task_post_setuid,
+	.task_setgid =			dummy_task_setgid,
+	.task_setpgid =			dummy_task_setpgid,
+	.task_getpgid =			dummy_task_getpgid,
+	.task_getsid =			dummy_task_getsid,
+	.task_setgroups =		dummy_task_setgroups,
+	.task_setnice =			dummy_task_setnice,
+	.task_setrlimit =		dummy_task_setrlimit,
+	.task_setscheduler =		dummy_task_setscheduler,
+	.task_getscheduler =		dummy_task_getscheduler,
+	.task_wait =			dummy_task_wait,
+	.task_kill =			dummy_task_kill,
+	.task_prctl =			dummy_task_prctl,
+	.task_kmod_set_label =		dummy_task_kmod_set_label,
+	.task_reparent_to_init =	dummy_task_reparent_to_init,
 	
-	register_security:		dummy_register,
-	unregister_security:		dummy_unregister,
+	.register_security =		dummy_register,
+	.unregister_security =		dummy_unregister,
 };
 
