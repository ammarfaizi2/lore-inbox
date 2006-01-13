Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWAMNis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWAMNis (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWAMNis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:38:48 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:62990 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1422665AbWAMNiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:38:46 -0500
Message-ID: <43C7AD5A.2000700@symas.com>
Date: Fri, 13 Jan 2006 05:38:34 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060111 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: epoll_wait, epoll_ctl
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, what's supposed to happen in a threaded program where one thread 
does an epoll_ctl on an epoll fd while another thread is currently 
waiting in epoll_wait on the same fd? In particular, what happens if a 
thread does an EPOLL_CTL_DEL on one of the fds that is currently being 
waited on? Is there a possibility of an event being returned on the fd 
even after the EPOLL_CTL_DEL completes?

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

