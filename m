Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266076AbUF2V1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUF2V1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbUF2V1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:27:19 -0400
Received: from mail.enyo.de ([212.9.189.167]:15623 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266076AbUF2V1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:27:09 -0400
To: Lincoln Dale <ltd@cisco.com>
Cc: "David S. Miller" <davem@redhat.com>, saiprathap <saiprathap@cc.usu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
References: <40DC9B00@webster.usu.edu> <40DC9B00@webster.usu.edu>
	<5.1.0.14.2.20040629122704.04958ec8@171.71.163.14>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 29 Jun 2004 23:27:00 +0200
In-Reply-To: <5.1.0.14.2.20040629122704.04958ec8@171.71.163.14> (Lincoln
 Dale's message of "Tue, 29 Jun 2004 12:34:01 +1000")
Message-ID: <874qou12e3.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lincoln Dale:

> the vulnerabilities are real for any application/protocol which makes
> use of long-duration TCP sessions.

... *and* which hasn't got fast recovery from connection loss.

For example, NNTP uses long-lived TCP connections, but it is NOT
vulnerable because restart is very cheap.

Given the other benefits of fast recovery, it's better to concentrate
on that than to tack something on the TCP stack which only solves a
tiny subset of the problems (which isn't even relevant in practice).
