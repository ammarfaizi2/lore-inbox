Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVLQI5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVLQI5c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 03:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLQI5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 03:57:32 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:28462 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932194AbVLQI5b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 03:57:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MH/mQCQWsBjC4SG3amYt4XQ47ubi+p6nnEJfL3CS+ghdUY/TtrLYyNcTi86T1yYuyBBY46Dihs43/VhGLuAg4w9iwJSy6xMScG+jkWdWexFrOX/XyDEkVR1tJKMm9jxOkELyIX5JU00j/CT01QC8uUXtUtZsJ70b6bqcIUcOzpw=
Message-ID: <3fe1d240512170057h2a1e0929o@mail.gmail.com>
Date: Sat, 17 Dec 2005 16:57:30 +0800
From: Hua Feijun <hua.feijun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: stop threads failed!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to set threads's status to TASK_STOPPED by the following
code.The syslog has show this rourine has been executed,buf the thread
is still running.Who can tell me the reason?Thanks very much!
write_lock(&tasklist_lock);
do
{
printk("set threads stopped\n");			
p->state = TASK_STOPPED;
} while ((p = next_thread(p)) != leader);
write_unlock(&tasklist_lock);
schedule();
