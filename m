Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTJ3KWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTJ3KWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:22:54 -0500
Received: from spectre.fbab.net ([212.214.165.139]:34960 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S262333AbTJ3KWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:22:53 -0500
Message-ID: <3FA0E677.5030402@fbab.net>
Date: Thu, 30 Oct 2003 11:22:47 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sreeram Kumar Ravinoothala <sreeram.ravinoothala@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question on SIGFPE
References: <94F20261551DC141B6B559DC491086727C8C63@blr-m3-msg.wipro.com>
In-Reply-To: <94F20261551DC141B6B559DC491086727C8C63@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sreeram Kumar Ravinoothala wrote:

 > Hi,
 > 	We get this problem when we run it on disk on chip where linux
 > 2.4.5 is used.
 >
 > Thanks and Regards
 > Sreeram

Since I don't know what your app is doing, it's kind of hard to know 
whats causing the problem. I still would guess on a divide by zero, 
maybe because of some timing issue.

Use sigaction(2) to trap the signal, and then look at the 
siginfo_t->si_addr to find out where it happens.

Or better yet, just run the program through gdb, it will catch the thing...

Magnus

