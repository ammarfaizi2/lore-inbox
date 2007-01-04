Return-Path: <linux-kernel-owner+w=401wt.eu-S932301AbXADHAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbXADHAX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbXADHAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:00:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:1246 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbXADHAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:00:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JjvFU0RazU8QtllvKRHn+28gFG2CXkB7ioByj1KZTAV+TUo1vUY0QdIi8QQSTqzagUxJG+5xlUdK3fgCcb+ZBpZEE3S4n7L3IbnLNZHicchKi8eF7vl6uWAi36rd9wr3lCP+gp9BHz/UStmkohXXwmwqAhfZVavQrN3sEFwOaEk=
Message-ID: <8bd0f97a0701032300u1b1b45c7jebd3dbddfb1df27d@mail.gmail.com>
Date: Thu, 4 Jan 2007 02:00:20 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: useless asm/page.h exported to userspace for some architectures
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

most architectures (pretty much everyone but like x86/x86_64/s390)
export empty asm/page.h headers ... considering how useless these are,
why bother exporting them at all ?  clearly userspace is unable to
rely on it across architectures, so by making it available to the two
most common (x86/x86_64), applications crop up that build "fine" on
them but fail just about everywhere else
-mike
