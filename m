Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTLCSv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbTLCSvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:51:25 -0500
Received: from mra02.ex.eclipse.net.uk ([212.104.129.89]:64748 "EHLO
	mra02.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S265127AbTLCSvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:51:22 -0500
Message-ID: <3FCE30A7.4080600@jon-foster.co.uk>
Date: Wed, 03 Dec 2003 18:51:19 +0000
From: Jon Foster <jon@jon-foster.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: joe.korty@ccur.com
Subject: Re:[PATCH, 2.6.0-test11] more correct get_compat_timespec interface
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 >-int put_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
 >+int put_compat_timespec(struct timespec *ts, const struct 
compat_timespec *cts)
 >{
 >return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
 >__put_user(ts->tv_sec, &cts->tv_sec) ||

Shouldn't the "const" be on the other argument?

Kind regards,

Jon Foster

