Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUEBEWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUEBEWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 00:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUEBEWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 00:22:33 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:4040 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261321AbUEBEWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 00:22:19 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.3  (F2.71; T1.001; A1.60; B2.21; Q2.21)
From: project8sem4@fastmail.fm
To: linux-kernel@vger.kernel.org
Date: Sat, 01 May 2004 21:22:19 -0700
X-Sasl-Enc: 7/ZvCzzEeBNWoy9ic18Wfw 1083471739
Message-Id: <1083471739.12474.185480952@webmail.messagingengine.com>
Subject: wierd current->uid in module
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




hi 
i am new to the kernel. i am working on a simple
 system call interception module that is supposed
 to return the uid of the user who made the call.
 this i do by using current->uid.
 
a fragment of my code:
 
//in kernel module
 asmlinkage long my_mkdir(const char * filename)
 {
         sprintf(buffer,"%s,%i",filename, current->uid);
         //this buffer is later read.
         return original_mkdir( filename);
 }
 
the problem is that the current->uid value always 
turns out to be -1, whether its root or a non-root
 user.
 im using redhat 7.2 (kernel 2.4.7-10)
 can anyone please help me out..
 thanx in advance,
 kt
 

-- 
http://www.fastmail.fm - mmm... Fastmail...
