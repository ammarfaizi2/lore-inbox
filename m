Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUEBETm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUEBETm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 00:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUEBETm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 00:19:42 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43698 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261258AbUEBETk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 00:19:40 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.3  (F2.71; T1.001; A1.60; B2.21; Q2.21)
From: project8sem4@fastmail.fm
To: linux-kernel@vger.kernel.org
Date: Sat, 01 May 2004 21:19:40 -0700
X-Sasl-Enc: F77g99ehCNMClUjvftnXwQ 1083471580
Message-Id: <1083471580.11934.185480850@webmail.messagingengine.com>
Subject: wierd current->uid in module
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
 i am doing a project on
 a very simple system call interception module.
 the module is supposed to return the  uid of the 
user who made the call to the syscall. i m trying to 
do it thus:
 
//in the kernel module
 asmlinkage long my_syscall(arg1,arg2)
 {
         sprintf(buffer, "%s%s%i", arg1,arg2,current->uid);
         //this buffer is later read.
         return original_syscall(arg1,arg2);
 }
 
the problem is that the uid returned is always -1 
whether the user is root or otherwise. 
could you suggest a way out please.
 thanx
 -kt
 

-- 
http://www.fastmail.fm - The way an email service should be
