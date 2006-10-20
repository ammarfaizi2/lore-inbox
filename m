Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992724AbWJTXft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992724AbWJTXft (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWJTXft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:35:49 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2773 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161087AbWJTXfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:35:48 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.4.3
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net>
Date: Fri, 20 Oct 2006 16:35:47 -0700
In-Reply-To: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Oct 2006 16:53:22 -0700")
Message-ID: <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>  - git-diff paginates its output to the tty by default.  If this
>    irritates you, using LESS=RF might help.

I am considering the following to address irritation some people
(including me, actually) are experiencing with this change when
viewing a small (or no) diff.  Any objections?

diff --git a/pager.c b/pager.c
index dcb398d..8bd33a1 100644
--- a/pager.c
+++ b/pager.c
@@ -50,7 +50,7 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	setenv("LESS", "-RS", 0);
+	setenv("LESS", "FRS", 0);
 	run_pager(pager);
 	die("unable to execute pager '%s'", pager);
 	exit(255);

